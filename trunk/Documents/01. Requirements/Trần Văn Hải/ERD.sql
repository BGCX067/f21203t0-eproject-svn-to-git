
GO 
CREATE DATABASE WebPhotoShare
GO
USE WebPhotoShare
GO
CREATE TABLE admins
(
	username			VARCHAR(32)	PRIMARY KEY NOT NULL,
	[password]			VARCHAR(32)	NOT NULL
)
GO
CREATE TABLE contact
(
	contact_id			INT PRIMARY KEY IDENTITY NOT NULL,
	contact_name		VARCHAR(255) NOT NULL,
	contact_email		VARCHAR(255),
	contact_subject		VARCHAR(255),
	contact_message		TEXT,
	contact_reply		TEXT,
	contact_status		TINYINT NOT NULL DEFAULT 0,
	contact_date		DATETIME,
	reply_date			DATETIME

)
GO
CREATE TABLE faqs
(
	faq_id				INT PRIMARY KEY IDENTITY NOT NULL,
	[question]			VARCHAR(255),
	[answer]			TEXT
)
GO
CREATE TABLE feedbacks
(
	feedback_id			INT PRIMARY KEY IDENTITY NOT NULL,
	[user_id]			INT				NOT NULL,
	[subject]			VARCHAR(255),
	[message]			TEXT	,
	[reply]				TEXT	,
	[status]			TINYINT			NOT NULL DEFAULT 0,
	feedback_date		DATETIME,
	reply_date 			DATETIME
)
GO
CREATE TABLE collections
(
	collection_id		INT PRIMARY KEY IDENTITY NOT NULL,
	[title]				VARCHAR(255),
	[status]			BIT NOT NULL DEFAULT 0
)
GO 
CREATE TABLE users
(
	[user_id]			INT PRIMARY KEY IDENTITY NOT NULL,
	[name]				VARCHAR(255)	NOT NULL,
	[username]			VARCHAR(32)		NOT NULL CONSTRAINT Username_Unique UNIQUE([username]),
	[password]			VARCHAR(32)		NOT NULL,
	[email]				VARCHAR(255)	NOT NULL CONSTRAINT Email_Unique UNIQUE([email]),
	[address]			VARCHAR(255),
	[gender]			BIT	DEFAULT 0	NOT NULL,
	birth_year			VARCHAR(4)		NOT NULL,
	user_status			TINYINT			NOT NULL DEFAULT 0,
	reset_password_key	VARCHAR(32),
	join_date			DATETIME
)
GO
CREATE TABLE images
(
	image_id			INT PRIMARY KEY IDENTITY NOT NULL,
	[title]				VARCHAR(255)		NOT NULL,
	[user_id]			INT					NOT NULL,
	collection_id		INT					NOT NULL,
	[description]		TEXT,
	[filename]			VARCHAR(255)		NOT NULL,
	[path]				VARCHAR(255)		NOT NULL,
	share_status		TINYINT	DEFAULT 0	NOT NULL,
	upload_date			DATETIME,
	modify_date			DATETIME

)
GO
CREATE TABLE comments
(
	comment_id			INT PRIMARY KEY IDENTITY NOT NULL,
	image_id			INT NOT NULL,
	[comment]			TEXT,
	comment_date		DATETIME
)
GO
CREATE TABLE user_friends
(	
	friend_id			INT PRIMARY KEY IDENTITY NOT NULL,
	[user_id]			INT NOT NULL,
	[friend]			INT NOT NULL,
	request_status		BIT NOT NULL DEFAULT 0
)
GO
ALTER TABLE feedbacks
	ADD CONSTRAINT FK_FEEDBACK_USERS foreign key([user_id]) references users([user_id])
GO
ALTER TABLE images
	ADD CONSTRAINT FK_IMAGES_USERS foreign key(collection_id) references collections(collection_id)
GO
ALTER TABLE images
	ADD CONSTRAINT FK_IMAGES_COLLECTIONS foreign key([user_id]) references users([user_id])
GO
ALTER TABLE comments
	ADD CONSTRAINT FK_IMAGES_COMMENT foreign key(image_id) references images(image_id)
GO
ALTER TABLE user_friends
	ADD CONSTRAINT FK_USER_FRIENDS foreign key([user_id]) references users([user_id])
GO
ALTER TABLE user_friends
	ADD CONSTRAINT FK_FRIENDS_USER foreign key([friend]) references users([user_id])
	




