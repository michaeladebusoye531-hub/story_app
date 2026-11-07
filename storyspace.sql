CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stories (
    story_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    category TEXT,
    description TEXT,
    content TEXT NOT NULL,
    date_published DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    story_id INTEGER NOT NULL,
    comment TEXT NOT NULL,
    date_commented DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (story_id) REFERENCES stories(story_id)
);

CREATE TABLE likes (
    like_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    story_id INTEGER NOT NULL,
    UNIQUE(user_id, story_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (story_id) REFERENCES stories(story_id)
);