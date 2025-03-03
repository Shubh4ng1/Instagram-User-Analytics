use ig_clone; /* choosing the database*/
select * from follows;/* looking into the tables one by one*/
select * from likes;
select * from photo_tags;
select * from photos;
select * from tags;
select * from users;

/*A) Marketing Analysis:
Loyal User Reward: The marketing team wants to reward the most loyal users, i.e., those who have been using the platform for the longest time.
Task: Identify the five oldest users on Instagram from the provided database.*/
SELECT 
    id, username, created_at
FROM
    users
ORDER BY created_at
LIMIT 5;

/*Inactive User Engagement: The team wants to encourage inactive users to start posting by sending them promotional emails.
Task: Identify users who have never posted a single photo on Instagram.*/
SELECT 
    *
FROM
    users
WHERE
    users.id NOT IN (SELECT 
            user_id
        FROM
            photos);
/*Contest Winner Declaration: The team has organized a contest where the user with the most likes on a single photo wins.
Task: Determine the winner of the contest and provide their details to the team.*/
SELECT 
    users.username,
    photos.id,
    photos.image_url,
    COUNT(*) AS max_likes
FROM
    photos
        INNER JOIN
    likes ON likes.photo_id = photos.id
        INNER JOIN
    users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY max_likes DESC
LIMIT 1;

/*Hashtag Research: A partner brand wants to know the most popular hashtags to use in their posts to reach the most people.
Task: Identify and suggest the top five most commonly used hashtags on the platform.*/
SELECT 
    t.tag_name AS 'name of tag',
    COUNT(p.photo_id) AS hashtag_frequency
FROM
    photo_tags AS p
        INNER JOIN
    tags AS t ON t.id = p.tag_id
GROUP BY t.tag_name
ORDER BY hashtag_frequency DESC
LIMIT 5;

/*Ad Campaign Launch: The team wants to know the best day of the week to launch ads.
Task: Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.*/
SELECT 
    DAYNAME(created_at) AS day_,
    COUNT(id) AS no_of_registrations
FROM
    users
GROUP BY day_
ORDER BY no_of_registrations DESC


/*Investor Metrics:
Your Task: Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram and the total number of users*/
SELECT 
    USER_ID, COUNT(ID) AS COUNTS
FROM
    PHOTOS
GROUP BY user_id;-- average post per person

SELECT 
    COUNT(*) AS total_ig_images
FROM
    photos;-- total photos
SELECT 
    COUNT(username) AS total_ig_users
FROM
    users;-- total users

/*Your Task: Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.*/
SELECT 
    photo_id,COUNT(user_id) AS Likes
FROM
   likes
GROUP BY photo_id
ORDER BY photo_id