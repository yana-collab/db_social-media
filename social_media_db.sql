DROP DATABASE IF EXISTS social_media_db;
CREATE DATABASE social_media_db;

CREATE TABLE users (
id SERIAL,
phone BIGINT,
email VARCHAR (120),
password_hash VARCHAR(100),
created_at DATETIME DEFAULT NOW(),

INDEX users_phone_idx(phone)

);


CREATE TABLE animal_types (
id SERIAL,
name VARCHAR (255),
created_at DATETIME,

INDEX animals_type_name_idx(name)
);


CREATE TABLE cities (
id SERIAL,
name VARCHAR (255),
created_at DATETIME,

INDEX city_name_idx (name)
);


CREATE TABLE files_category (
id SERIAL,
category_name VARCHAR (255),
created_at DATETIME,

INDEX category_name_idx (category_name)
);


CREATE TABLE titles (
id SERIAL,
name VARCHAR (255),
created_at DATETIME,

INDEX title_name_idx (name)
);


CREATE TABLE files (
id SERIAL,
file_category_id BIGINT UNSIGNED NOT NULL,
creater_id BIGINT UNSIGNED NOT NULL,
filename VARCHAR (255),
path_file VARCHAR (255),
size_file INT,
metadata JSON,
created_at DATETIME,

INDEX filename_idx(filename),
FOREIGN KEY (file_category_id) REFERENCES files_category(id),
FOREIGN KEY (creater_id) REFERENCES users(id)
);


CREATE TABLE profiles (
id SERIAL,
user_id BIGINT UNSIGNED NOT NULL,
nickname VARCHAR (120),
gender ENUM ('M', 'F', 'X'),
animal_type_id BIGINT UNSIGNED,
avatar BIGINT UNSIGNED DEFAULT 1,
hometown_id BIGINT UNSIGNED,
date_of_birth DATE,
created_at DATETIME,
updated_at DATETIME,

INDEX users_nickname_idx(nickname),

FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (animal_type_id) REFERENCES animal_types(id),
FOREIGN KEY (hometown_id) REFERENCES cities(id)
);


CREATE TABLE messages (
id SERIAL,
from_user BIGINT UNSIGNED NOT NULL,
to_user BIGINT UNSIGNED NOT NULL,
voice_content BLOB,
attached_file_id BIGINT UNSIGNED NOT NULL,
created_at DATETIME,

FOREIGN KEY (from_user) REFERENCES users(id),
FOREIGN KEY (to_user) REFERENCES users(id),
FOREIGN KEY (attached_file_id) REFERENCES files(id)
);


CREATE TABLE users_posts (
id SERIAL,
user_id BIGINT UNSIGNED NOT NULL,
title_id BIGINT UNSIGNED NOT NULL,
attached_file_id BIGINT UNSIGNED,
created_at DATETIME,

FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (attached_file_id) REFERENCES files(id),
FOREIGN KEY (title_id) REFERENCES titles(id)
);


CREATE TABLE retweet_posts (
post_id BIGINT UNSIGNED NOT NULL,
user_id BIGINT UNSIGNED NOT NULL,
created_at DATETIME,

FOREIGN KEY (post_id) REFERENCES users_posts(id),
FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE followers (
follower_id BIGINT UNSIGNED NOT NULL,
target_id BIGINT UNSIGNED NOT NULL,
created_at DATETIME,
status BIT DEFAULT 0,
updated_at DATETIME,

FOREIGN KEY (follower_id) REFERENCES users(id),
FOREIGN KEY (target_id) REFERENCES users(id)
);


















