SELECT 
    *
FROM
    `ig_clone`.`comments`;
SELECT 
    *
FROM
    `ig_clone`.`follows`;
SELECT 
    *
FROM
    `ig_clone`.`likes`;
SELECT 
    *
FROM
    `ig_clone`.`photo_tags`;
SELECT 
    *
FROM
    `ig_clone`.`photos`;
SELECT 
    *
FROM
    `ig_clone`.`tags`;
SELECT 
    *
FROM
    `ig_clone`.`users`;
SELECT 
    *
FROM
    `ig_clone`.`users`
ORDER BY `created_at` ASC
LIMIT 0 , 5;
SELECT 
    WEEKDAY(`created_at`) `Day Number of the Week`,
    DAYNAME(`created_at`) AS `Day Name`,
    COUNT(DAYNAME(`created_at`)) AS `Total Number of users registered`
FROM
    `ig_clone`.`users`
WHERE
    WEEKDAY(`created_at`) IN (0 , 1, 2, 3, 4, 5, 6)
GROUP BY DAYNAME(`created_at`) , WEEKDAY(`created_at`)
ORDER BY WEEKDAY(`created_at`) ASC;
SELECT 
    *
FROM
    (SELECT DISTINCT
        p.`user_id`, u.`username`, u.`id`
    FROM
        `ig_clone`.`users` AS u
    LEFT JOIN `ig_clone`.`photos` AS p ON u.`id` = p.`user_id`) AS Q
WHERE
    `user_id` IS NULL;
SELECT 
    ROUND(COUNT(`image_url`) / 100) AS `Average Posts per day`
FROM
    `ig_clone`.`photos`
WHERE
    `user_id` IN (SELECT 
            `user_id`
        FROM
            `ig_clone`.`photos`);
SELECT 
    p.`user_id`,
    COUNT(p.`user_id`) AS `Total Posts per user`,
    u.`username`
FROM
    `ig_clone`.`photos` AS p
        LEFT JOIN
    `ig_clone`.`users` AS u ON u.`id` = p.`user_id`
GROUP BY `user_id`;
SELECT 
    *
FROM
    (SELECT DISTINCT
        p.`user_id`, u.`username`
    FROM
        `ig_clone`.`users` AS u
    LEFT JOIN `ig_clone`.`photos` AS p ON u.`id` = p.`user_id`) AS Q
WHERE
    `user_id` IS NOT NULL;
SELECT 
    pt.`tag_id`,
    t.`tag_name`,
    COUNT(pt.`tag_id`) AS `Number of times the tag was used`
FROM
    `ig_clone`.`photo_tags` AS pt
        LEFT JOIN
    `ig_clone`.`tags` AS t ON t.`id` = pt.`tag_id`
GROUP BY `tag_id`
ORDER BY COUNT(`tag_id`) DESC
LIMIT 0 , 5;
SELECT 
    u.`username`, COUNT(p.`id`) AS `Likes`, l.`user_id`
FROM
    `ig_clone`.`likes` AS l
        LEFT JOIN
    `ig_clone`.`photos` AS p ON p.`id` = l.`photo_id`
        LEFT JOIN
    `ig_clone`.`users` AS u ON u.`id` = l.`user_id`
GROUP BY l.`user_id`
ORDER BY COUNT(p.`id`) DESC
LIMIT 0 , 12;
select  (count(Q.`TU`)/(select count(`id`) from ig_clone.users)) * 100 as `percentage of users who never commented`, (select count(*)/(select count(`id`) as `percentage` from ig_clone.users)*100 from (select  user_id as `UID`, count(photo_id) as count from ig_clone.likes  group by user_id having count = (SELECT count(*) FROM ig_clone.photos)) as t1) as `Percentage of users who liked all the pictures`
 from (SELECT 
    u.`id` as `TU` ,COUNT(c.`user_id`)as `number of comments`
FROM
    `ig_clone`.`users` AS u
        LEFT JOIN
    `ig_clone`.`comments` AS c ON u.`id` =c.`user_id` group by u.`id` having `number of comments` = 0) as Q;

SELECT DISTINCT
    u.`username`, u.`id`, c.`user_id`
FROM
    `ig_clone`.`users` AS u
        LEFT JOIN
    `ig_clone`.`comments` AS c ON u.`id` = c.`user_id`
WHERE
    c.`user_id` IS NULL;
SELECT DISTINCT
    u.`username`, u.`id`, c.`user_id`
FROM
    `ig_clone`.`users` AS u
        LEFT JOIN
    `ig_clone`.`comments` AS c ON u.`id` = c.`user_id`
WHERE
    c.`user_id` IS NOT NULL