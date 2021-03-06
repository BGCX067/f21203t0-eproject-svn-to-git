USE [master]
GO
/****** Object:  Database [WebPhotoShare]    Script Date: 10/23/2013 12:27:35 ******/
CREATE DATABASE [WebPhotoShare]
GO
ALTER DATABASE [WebPhotoShare] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebPhotoShare].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebPhotoShare] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [WebPhotoShare] SET ANSI_NULLS OFF
GO
ALTER DATABASE [WebPhotoShare] SET ANSI_PADDING OFF
GO
ALTER DATABASE [WebPhotoShare] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [WebPhotoShare] SET ARITHABORT OFF
GO
ALTER DATABASE [WebPhotoShare] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [WebPhotoShare] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [WebPhotoShare] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [WebPhotoShare] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [WebPhotoShare] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [WebPhotoShare] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [WebPhotoShare] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [WebPhotoShare] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [WebPhotoShare] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [WebPhotoShare] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [WebPhotoShare] SET  DISABLE_BROKER
GO
ALTER DATABASE [WebPhotoShare] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [WebPhotoShare] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [WebPhotoShare] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [WebPhotoShare] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [WebPhotoShare] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [WebPhotoShare] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [WebPhotoShare] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [WebPhotoShare] SET  READ_WRITE
GO
ALTER DATABASE [WebPhotoShare] SET RECOVERY FULL
GO
ALTER DATABASE [WebPhotoShare] SET  MULTI_USER
GO
ALTER DATABASE [WebPhotoShare] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [WebPhotoShare] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebPhotoShare', N'ON'
GO
USE [WebPhotoShare]
GO
/****** Object:  Table [dbo].[collections]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[collections](
	[collection_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NULL,
	[status] [bit] NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[collection_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[collections] ON
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (1, N'Animals', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (2, N'Architecture', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (3, N'Art', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (4, N'Cars &amp; Motorcycles', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (5, N'Celebrities', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (6, N'Design', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (7, N'DIY &amp; Crafts', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (8, N'Education', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (9, N'Film, Music &amp; Books', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (10, N'Food &amp; Drink', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (11, N'Gardening', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (12, N'Geek', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (13, N'Hair &amp; Beauty', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (14, N'Health &amp; Fitness', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (15, N'History', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (16, N'Holidays &amp; Events', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (17, N'Home Decor', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (18, N'Humor', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (19, N'Illustrations &amp; Posters', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (20, N'Kids', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (21, N'Men''s Fashion', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (22, N'Outdoors', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (23, N'Photography', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (24, N'Products', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (25, N'Quotes', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (26, N'Science &amp; Nature', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (27, N'Sports', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (28, N'Tattoos', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (29, N'Technology', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (30, N'Travel', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (31, N'Weddings', 1, N'')
INSERT [dbo].[collections] ([collection_id], [title], [status], [description]) VALUES (32, N'Women''s Fashion', 1, N'')
SET IDENTITY_INSERT [dbo].[collections] OFF
/****** Object:  Table [dbo].[admins]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admins](
	[username] [varchar](32) NOT NULL,
	[password] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[admins] ([username], [password]) VALUES (N'admin', N'21232f297a57a5a743894a0e4a801fc3')
/****** Object:  Table [dbo].[faqs]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[faqs](
	[faq_id] [int] IDENTITY(1,1) NOT NULL,
	[question] [varchar](255) NULL,
	[answer] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[faq_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[faqs] ON
INSERT [dbo].[faqs] ([faq_id], [question], [answer]) VALUES (1, N'How to view the image files?', N'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br /><br />Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')
INSERT [dbo].[faqs] ([faq_id], [question], [answer]) VALUES (2, N'How to register with the site?', N'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br />Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br />Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br />Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
INSERT [dbo].[faqs] ([faq_id], [question], [answer]) VALUES (3, N'How to upload the picture file?', N'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. <br />Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.')
INSERT [dbo].[faqs] ([faq_id], [question], [answer]) VALUES (4, N'How to post a Query', N'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. <br />Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? <br />Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?')
INSERT [dbo].[faqs] ([faq_id], [question], [answer]) VALUES (5, N'Is there any limitation in uploading files?', N'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga<br />Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.')
SET IDENTITY_INSERT [dbo].[faqs] OFF
/****** Object:  Table [dbo].[contact]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contact](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_name] [varchar](255) NOT NULL,
	[contact_email] [varchar](255) NULL,
	[contact_subject] [varchar](255) NULL,
	[contact_message] [text] NULL,
	[contact_reply] [text] NULL,
	[contact_status] [tinyint] NOT NULL,
	[contact_date] [datetime] NULL,
	[reply_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[contact] ON
INSERT [dbo].[contact] ([contact_id], [contact_name], [contact_email], [contact_subject], [contact_message], [contact_reply], [contact_status], [contact_date], [reply_date]) VALUES (1, N'Hung Nguyen', N'hunguyenv@gmail.com', N'This is subject', N'This is contact message', N'asd', 2, CAST(0x0000A25F00BA4F3B AS DateTime), CAST(0x0000A25F00C32444 AS DateTime))
SET IDENTITY_INSERT [dbo].[contact] OFF
/****** Object:  Table [dbo].[users]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[username] [varchar](32) NOT NULL,
	[password] [varchar](32) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[address] [varchar](255) NULL,
	[gender] [bit] NOT NULL,
	[birth_year] [varchar](4) NOT NULL,
	[user_status] [tinyint] NOT NULL,
	[reset_password_key] [varchar](32) NULL,
	[join_date] [datetime] NULL,
	[user_avatar] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Email_Unique] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Username_Unique] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (1, N'Hung Nguyen', N'hunguyenv', N'f5e6931d521e3658d655d0527a3c1ae3', N'hunguyenv@gmail.com', NULL, 0, N'1984', 1, NULL, NULL, N'c4ca4238a0b923820dcc509a6f75849b.jpg')
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (3, N'demo1', N'user1', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user1@mail.com', N'', 0, N'1984', 1, NULL, NULL, N'eccbc87e4b5ce2fe28308fd9f2a7baf3.jpg')
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (4, N'demo2', N'user2', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user2@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (5, N'demo3', N'user3', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user3@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (6, N'demo4', N'user4', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user4@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (7, N'demo5', N'user5', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user5@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (8, N'demo6', N'user6', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user6@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (9, N'demo7', N'user7', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user7@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (10, N'demo8', N'user8', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user8@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (11, N'demo9', N'user9', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user9@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
INSERT [dbo].[users] ([user_id], [name], [username], [password], [email], [address], [gender], [birth_year], [user_status], [reset_password_key], [join_date], [user_avatar]) VALUES (12, N'demo10', N'user10', N'fe01ce2a7fbac8fafaed7c982a04e229', N'user10@mail.com', NULL, 0, N'1984', 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
/****** Object:  Table [dbo].[user_friends]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_friends](
	[friend_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[friend] [int] NOT NULL,
	[request_status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[friend_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[user_friends] ON
INSERT [dbo].[user_friends] ([friend_id], [user_id], [friend], [request_status]) VALUES (1, 3, 4, 1)
INSERT [dbo].[user_friends] ([friend_id], [user_id], [friend], [request_status]) VALUES (2, 3, 5, 0)
INSERT [dbo].[user_friends] ([friend_id], [user_id], [friend], [request_status]) VALUES (3, 3, 6, 0)
INSERT [dbo].[user_friends] ([friend_id], [user_id], [friend], [request_status]) VALUES (4, 3, 7, 0)
INSERT [dbo].[user_friends] ([friend_id], [user_id], [friend], [request_status]) VALUES (5, 3, 8, 0)
SET IDENTITY_INSERT [dbo].[user_friends] OFF
/****** Object:  Table [dbo].[images]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[images](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[user_id] [int] NOT NULL,
	[collection_id] [int] NOT NULL,
	[description] [text] NULL,
	[filename] [varchar](255) NOT NULL,
	[path] [varchar](255) NOT NULL,
	[share_status] [tinyint] NOT NULL,
	[upload_date] [datetime] NULL,
	[modify_date] [datetime] NULL,
	[view_count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[images] ON
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (1, N'How to tie your shoes', 3, 21, N'', N'22c8b3c3480af0ab1495ac3626629f0.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E0178EB10 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (2, N'How to tie your shoes', 3, 21, N'', N'bba6dea27e4773ee681b015543c48ab7.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E017901B6 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (3, N'How to tie your shoes', 3, 21, N'', N'a2f54f25d77a81e4cc3960a4b4c2e780.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E01790C60 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (4, N'How to tie your shoes', 3, 21, N'', N'67e37df7ad0afb6f43213700a6ea0d5f.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E017918F2 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (5, N'How to tie your shoes', 3, 21, N'', N'd550f9d5637a03f156699e96ca7501de.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E0179262F AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (6, N'How to tie your shoes', 3, 21, N'', N'25694047171b681ecdb805e7ff614fff.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E017936B6 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (7, N'How to tie your shoes', 3, 21, N'', N'598c889e16aa5ee8d05afb06753fea57.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E01794CC0 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (8, N'How to tie your shoes', 3, 21, N'', N'dec7728edc89540a185eb5dfc3b2e34b.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E017959F0 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (9, N'How to tie your shoes', 3, 21, N'', N'55aeae9451c32dea5daa9e6bf409fabc.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E017967A9 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (10, N'How to tie your shoes', 3, 21, N'', N'3128ac1e3d43a5859fc7327460d4378b.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E01797113 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (11, N'How to tie your shoes', 3, 21, N'', N'6b7cf18d8878810638d939985a43aee6.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E01798067 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (12, N'How to tie your shoes', 3, 21, N'', N'7da4afef6d6d5561c1de5d3ecaa78014.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E01798DB9 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (13, N'How to tie your shoes', 3, 21, N'', N'6256ada80220b4682fda6d1c9cd12c05.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E01799857 AS DateTime), NULL, 4)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (14, N'How to tie your shoes', 3, 21, N'', N'6ccdf8b8682bb64c366da5545462b2dd.jpg', N'/uploads/2013-10-21', 2, CAST(0x0000A25E0179A351 AS DateTime), NULL, 11)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (15, N'Sample Pictures', 1, 19, N'', N'ca851fbc927c476eb93f8c1245e39b3f.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CAD257 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (16, N'Sample Pictures', 1, 11, N'', N'709dac780a3fd44338ddf1919c8a9cae.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CAE953 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (17, N'Sample Pictures', 1, 11, N'', N'96f08c6f64d0d6b3228d4f9350b8c6f5.jpg', N'/uploads/2013-10-23', 0, CAST(0x0000A26000CAF7F4 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (18, N'Sample Pictures', 1, 5, N'', N'8e85f43eb77fabbeae22b81e8bdb14b5.jpg', N'/uploads/2013-10-23', 1, CAST(0x0000A26000CB04BB AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (19, N'Sample Pictures', 1, 1, N'', N'c4f0c907a04168ce8b29358323a2d0b2.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB0E20 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (20, N'Sample Pictures', 1, 2, N'', N'c4799f128855fdf1bb494251848b8df7.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB1758 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (21, N'Sample Pictures', 1, 1, N'', N'adc37b912717310aa6aadfa58340aab1.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB2012 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (22, N'Sample Pictures', 1, 19, N'', N'b8c27256150290696a6145238c0082a8.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB2A50 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (23, N'Sample Pictures', 1, 3, N'', N'f12eb7dcc59ef5feb82bcdd53ff9b1ec.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB4B00 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (24, N'Sample Pictures', 1, 3, N'', N'29db31f71ef72b07e3087d60b273483b.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB5AA8 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (25, N'Sample Pictures', 1, 3, N'', N'37eac784530e12cc25089b7921bf0316.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB634D AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (26, N'Sample Pictures', 1, 3, N'', N'2f62d69ab97986e560b866244971c00d.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB6C84 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (27, N'Sample Pictures', 1, 3, N'', N'648128eaf807aab4248bd9cb4bb2c55b.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB7998 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (28, N'Sample Pictures', 1, 19, N'', N'5070fd0a51dfb363139c92e568f37a12.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB8412 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (29, N'Sample Pictures', 1, 1, N'', N'3783086c47ce5ee428e663c6218d6277.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB97C9 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (30, N'Sample Pictures', 1, 1, N'', N'199f2a72caa6c6fc15b97846a0fc2c0e.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CB9DF6 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (31, N'Sample Pictures', 1, 1, N'', N'460bbf14b3d5dd1a672035d2c7345182.jpg', N'/uploads/2013-10-23', 1, CAST(0x0000A26000CBA845 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (32, N'Sample Pictures', 1, 3, N'', N'a25aa57938a7dcaf3fa42ca672e4ef6e.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CBB703 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (33, N'Sample Pictures', 1, 20, N'', N'924b2bf5ff85779c1dddcd04ea43be8a.jpg', N'/uploads/2013-10-23', 0, CAST(0x0000A26000CBBF2B AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (34, N'Sample Pictures', 1, 20, N'', N'b9f76c63369e7ba1c7a5127f28ba0be1.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CBC959 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (35, N'Sample Pictures', 1, 20, N'', N'36cc31962cd119100232513b16e25cf3.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CBDBD8 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (36, N'Sample Pictures', 1, 2, N'', N'd62625af7b1ecce2aae474071fa429e8.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CBE76F AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (37, N'Sample Pictures', 1, 5, N'', N'3922e7b2a512a7b05a265c485c39e70d.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC02A9 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (38, N'Sample Pictures', 1, 1, N'', N'1a0a403eef272d0a2675afb1271fb9cc.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC2181 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (39, N'Sample Pictures', 1, 26, N'', N'bf5ab2c089c70f5bd3d7d149ab785ecb.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC2E5D AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (40, N'Sample Pictures', 1, 20, N'', N'1d2658a63fbf25a91cfba077a85239d5.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC4604 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (41, N'Sample Pictures', 1, 18, N'', N'f753ba50f39ba1889e4d1e5b3a898679.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC550E AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (42, N'Sample Pictures', 1, 3, N'', N'adfc194e5783bc2010c9c3e78dd45052.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC623E AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (43, N'Sample Pictures', 1, 4, N'', N'b23d0ee0ebbc01d001132467667c5076.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC6F4A AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (44, N'Sample Pictures', 1, 6, N'', N'16263a1996352a46f291472bc6a238a2.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC7C69 AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (45, N'Sample Pictures', 1, 6, N'', N'b3ddc1092ae05c55f099c971364c9a3c.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CC8E0E AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (46, N'Sample Pictures', 1, 3, N'', N'd8d209b28676a0364e06dc6d2058d024.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CCBF1E AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (47, N'Sample Pictures', 1, 3, N'', N'e645083fb4d9be82177c75ae722fc9c8.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CCCDCD AS DateTime), NULL, 0)
INSERT [dbo].[images] ([image_id], [title], [user_id], [collection_id], [description], [filename], [path], [share_status], [upload_date], [modify_date], [view_count]) VALUES (48, N'Sample Pictures', 1, 3, N'', N'8044e65e45b0e2db2994e361e47019e2.jpg', N'/uploads/2013-10-23', 2, CAST(0x0000A26000CCDF02 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[images] OFF
/****** Object:  Table [dbo].[feedbacks]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[feedbacks](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[subject] [varchar](255) NULL,
	[message] [text] NULL,
	[reply] [text] NULL,
	[status] [tinyint] NOT NULL,
	[feedback_date] [datetime] NULL,
	[reply_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[comments]    Script Date: 10/23/2013 12:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comments](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[image_id] [int] NOT NULL,
	[comment] [text] NULL,
	[comment_date] [datetime] NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Default [DF__collectio__statu__21B6055D]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[collections] ADD  DEFAULT ((0)) FOR [status]
GO
/****** Object:  Default [DF__contact__contact__22AA2996]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[contact] ADD  DEFAULT ((0)) FOR [contact_status]
GO
/****** Object:  Default [DF__users__gender__239E4DCF]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [gender]
GO
/****** Object:  Default [DF__users__user_stat__24927208]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [user_status]
GO
/****** Object:  Default [DF__user_frie__reque__25869641]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[user_friends] ADD  DEFAULT ((0)) FOR [request_status]
GO
/****** Object:  Default [DF__images__share_st__267ABA7A]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[images] ADD  DEFAULT ((0)) FOR [share_status]
GO
/****** Object:  Default [DF__images__view_cou__276EDEB3]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[images] ADD  DEFAULT ((0)) FOR [view_count]
GO
/****** Object:  Default [DF__feedbacks__statu__286302EC]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[feedbacks] ADD  DEFAULT ((0)) FOR [status]
GO
/****** Object:  ForeignKey [FK_FRIENDS_USER]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[user_friends]  WITH CHECK ADD  CONSTRAINT [FK_FRIENDS_USER] FOREIGN KEY([friend])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_friends] CHECK CONSTRAINT [FK_FRIENDS_USER]
GO
/****** Object:  ForeignKey [FK_USER_FRIENDS]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[user_friends]  WITH CHECK ADD  CONSTRAINT [FK_USER_FRIENDS] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_friends] CHECK CONSTRAINT [FK_USER_FRIENDS]
GO
/****** Object:  ForeignKey [FK_IMAGES_COLLECTIONS]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[images]  WITH CHECK ADD  CONSTRAINT [FK_IMAGES_COLLECTIONS] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[images] CHECK CONSTRAINT [FK_IMAGES_COLLECTIONS]
GO
/****** Object:  ForeignKey [FK_IMAGES_USERS]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[images]  WITH CHECK ADD  CONSTRAINT [FK_IMAGES_USERS] FOREIGN KEY([collection_id])
REFERENCES [dbo].[collections] ([collection_id])
GO
ALTER TABLE [dbo].[images] CHECK CONSTRAINT [FK_IMAGES_USERS]
GO
/****** Object:  ForeignKey [FK_FEEDBACK_USERS]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_FEEDBACK_USERS] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[feedbacks] CHECK CONSTRAINT [FK_FEEDBACK_USERS]
GO
/****** Object:  ForeignKey [FK_comments_users]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[comments] CHECK CONSTRAINT [FK_comments_users]
GO
/****** Object:  ForeignKey [FK_IMAGES_COMMENT]    Script Date: 10/23/2013 12:27:35 ******/
ALTER TABLE [dbo].[comments]  WITH CHECK ADD  CONSTRAINT [FK_IMAGES_COMMENT] FOREIGN KEY([image_id])
REFERENCES [dbo].[images] ([image_id])
GO
ALTER TABLE [dbo].[comments] CHECK CONSTRAINT [FK_IMAGES_COMMENT]
GO
