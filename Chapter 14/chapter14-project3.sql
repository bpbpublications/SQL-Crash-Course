CREATE TABLE authors ( 
    author_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name TEXT NOT NULL, 
    email TEXT UNIQUE NOT NULL, 
    bio TEXT 
); 

CREATE TABLE posts ( 
    post_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    author_id INTEGER NOT NULL, 
    title TEXT NOT NULL, 
    content TEXT NOT NULL, 
    published_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (author_id) REFERENCES authors(author_id) 
); 

CREATE TABLE comments ( 
    comment_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    post_id INTEGER NOT NULL, 
    commenter_name TEXT NOT NULL, 
    comment_text TEXT NOT NULL, 
    commented_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (post_id) REFERENCES posts(post_id) 
); 

INSERT INTO authors (name, email, bio) 
VALUES 
    ('John Doe', 'john.doe@example.com', 'Tech enthusiast and blogger'), 
    ('Jane Smith', 'jane.smith@example.com', 'Writer and digital marketer');

INSERT INTO posts (author_id, title, content) 
VALUES 
    (1, 'Introduction to SQLite', 'SQLite is a lightweight database system...'),
    (2, 'Marketing Strategies for 2024', 'The key to successful marketing is...');

INSERT INTO comments (post_id, commenter_name, comment_text) 
VALUES 
    (1, 'Alice', 'Great introduction to SQLite!'), 
    (1, 'Tom', 'I found this post very helpful. Thanks!'), 
    (2, 'Sarah', 'I will try these strategies for my campaigns.');

SELECT  
p.title,  
p.content,  
a.name AS author,  
p.published_date 
FROM posts p 
JOIN authors a ON p.author_id = a.author_id;

SELECT c.commenter_name, c.comment_text, c.commented_date 
FROM comments c 
WHERE c.post_id = 1; 

UPDATE posts 
SET title = 'Getting Started with SQLite' 
WHERE post_id = 1; 

UPDATE authors 
SET bio = 'Experienced tech blogger' 
WHERE email = 'john.doe@example.com'; 

DELETE FROM comments 
WHERE comment_id = 2;

DELETE FROM comments 
WHERE post_id = 1; 

DELETE FROM posts 
WHERE post_id = 1;

SELECT a.name, COUNT(p.post_id) AS post_count 
FROM authors a 
JOIN posts p ON a.author_id = p.author_id 
GROUP BY a.author_id;

SELECT p.title, COUNT(c.comment_id) AS comment_count 
FROM posts p 
JOIN comments c ON p.post_id = c.post_id 
GROUP BY p.post_id 
ORDER BY comment_count DESC 
LIMIT 1;

CREATE INDEX idx_author_id ON posts(author_id); 
CREATE INDEX idx_post_id ON comments(post_id); 