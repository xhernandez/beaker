-- Number of jobs that have been moved into a High or Urgent priority
-- status by user, over a given period.

SELECT
    tg_user.user_name AS user_name,
    count(tg_user.user_name) AS number_of_jobs_changed
FROM
    (SELECT activity.user_id as user_id
    FROM activity
        INNER JOIN recipeset_activity ON recipeset_activity.id = activity.id
        INNER JOIN recipe_set ON recipe_set.id = recipeset_activity.recipeset_id
        INNER JOIN job ON job.id = recipe_set.job_id
    WHERE
        activity.created BETWEEN '2012-09-01 00:00:00' AND '2012-11-30 23:59:59'
        AND new_value IN ('High', 'Urgent')
        AND old_value != new_value
    GROUP BY job.id) AS a
    LEFT JOIN tg_user ON tg_user.user_id = a.user_id

GROUP BY user_name;