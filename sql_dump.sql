USE [master]
GO
/****** Object:  Database [SimpleChatApp]    Script Date: 8/28/2022 10:01:41 PM ******/
CREATE DATABASE [SimpleChatApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SimpleChatApp', FILENAME = N'D:\Development\SSMS\SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SimpleChatApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SimpleChatApp_log', FILENAME = N'D:\Development\SSMS\SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SimpleChatApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SimpleChatApp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleChatApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleChatApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleChatApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleChatApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleChatApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleChatApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleChatApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleChatApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleChatApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleChatApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleChatApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleChatApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleChatApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleChatApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleChatApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleChatApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SimpleChatApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleChatApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleChatApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleChatApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleChatApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleChatApp] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [SimpleChatApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleChatApp] SET RECOVERY FULL 
GO
ALTER DATABASE [SimpleChatApp] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleChatApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleChatApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleChatApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleChatApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SimpleChatApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SimpleChatApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SimpleChatApp', N'ON'
GO
ALTER DATABASE [SimpleChatApp] SET QUERY_STORE = OFF
GO
USE [SimpleChatApp]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 8/28/2022 10:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chats]    Script Date: 8/28/2022 10:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chats](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[IsPrivate] [bit] NOT NULL,
 CONSTRAINT [PK_Chats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatUser]    Script Date: 8/28/2022 10:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatUser](
	[ChatsId] [int] NOT NULL,
	[UsersId] [int] NOT NULL,
 CONSTRAINT [PK_ChatUser] PRIMARY KEY CLUSTERED 
(
	[ChatsId] ASC,
	[UsersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 8/28/2022 10:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ChatId] [int] NOT NULL,
	[Value] [nvarchar](500) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateLastEdited] [datetime2](7) NULL,
	[RepliedUserId] [int] NULL,
	[VisibleToSender] [bit] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/28/2022 10:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220822154145_InitialCreate', N'6.0.8')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220827142016_AllowNullForMessageLastEdited', N'6.0.8')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220827170947_EditedMessageModel', N'6.0.8')
GO
SET IDENTITY_INSERT [dbo].[Chats] ON 

INSERT [dbo].[Chats] ([Id], [Title], [IsPrivate]) VALUES (1, N'test_admin', 1)
INSERT [dbo].[Chats] ([Id], [Title], [IsPrivate]) VALUES (2, N'group1', 0)
INSERT [dbo].[Chats] ([Id], [Title], [IsPrivate]) VALUES (3, N'group2', 0)
INSERT [dbo].[Chats] ([Id], [Title], [IsPrivate]) VALUES (5, N'admin_test1', 1)
INSERT [dbo].[Chats] ([Id], [Title], [IsPrivate]) VALUES (6, N'test_test1', 1)
SET IDENTITY_INSERT [dbo].[Chats] OFF
GO
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (1, 1)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (2, 1)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (3, 1)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (6, 1)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (1, 2)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (3, 2)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (5, 2)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (2, 3)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (3, 3)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (5, 3)
INSERT [dbo].[ChatUser] ([ChatsId], [UsersId]) VALUES (6, 3)
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (1, 1, 3, N'POAISDASDPOAS
ASDSADASD', CAST(N'2022-08-27T17:29:34.1020000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (2, 1, 1, N'Hey bro!', CAST(N'2022-08-27T17:50:51.7490000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (4, 1, 1, N'Salut!', CAST(N'2022-08-27T22:41:44.0220000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (5, 1, 1, N'Wtf', CAST(N'2022-08-27T22:42:05.0450000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (6, 2, 1, N'Hi!
I''m great!', CAST(N'2022-08-27T23:36:41.7700000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (7, 2, 1, N'Hi!
I''m good!', CAST(N'2022-08-27T23:37:00.4560000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (8, 1, 1, N'I don''t love you!', CAST(N'2022-08-27T23:43:19.4690000' AS DateTime2), CAST(N'2022-08-27T23:52:51.8940000' AS DateTime2), NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (9, 2, 1, N'I love you too brother!', CAST(N'2022-08-27T23:43:34.0540000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (10, 1, 1, N'AHAHHAHAHAHAH', CAST(N'2022-08-27T23:53:28.1110000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (11, 1, 1, N'AHAHHAHAHAHAH1', CAST(N'2022-08-27T23:53:30.1780000' AS DateTime2), CAST(N'2022-08-27T23:57:27.8210000' AS DateTime2), NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (13, 1, 1, N'AXAXAXAXAXAXAXAXAXAXA', CAST(N'2022-08-27T23:54:23.6590000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (14, 3, 3, N'HI GUYS!!!', CAST(N'2022-08-27T23:58:27.7670000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (20, 1, 1, N'Message 8', CAST(N'2022-08-28T01:34:20.3850000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (21, 1, 1, N'Message 9', CAST(N'2022-08-28T01:34:24.7010000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (22, 1, 1, N'Message 10', CAST(N'2022-08-28T01:34:28.8620000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (23, 1, 1, N'Message 11', CAST(N'2022-08-28T01:34:35.8170000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (24, 1, 1, N'Message 12', CAST(N'2022-08-28T01:34:39.0970000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (25, 1, 1, N'Message 13', CAST(N'2022-08-28T01:34:41.6420000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (26, 1, 1, N'Message 14', CAST(N'2022-08-28T01:34:43.4930000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (27, 1, 1, N'Message 15', CAST(N'2022-08-28T01:34:47.5860000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (28, 1, 1, N'Message 16', CAST(N'2022-08-28T01:35:07.7130000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (29, 1, 1, N'Message 17', CAST(N'2022-08-28T01:35:23.8130000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (30, 1, 1, N'Message 18', CAST(N'2022-08-28T01:35:27.1590000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (31, 1, 1, N'Message 19', CAST(N'2022-08-28T01:35:30.2810000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (32, 1, 1, N'Message 20', CAST(N'2022-08-28T01:35:32.8960000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (33, 1, 1, N'Message 21', CAST(N'2022-08-28T02:00:03.2800000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (34, 1, 1, N'Message 22', CAST(N'2022-08-28T02:00:12.9670000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (35, 1, 1, N'Message 23_edited', CAST(N'2022-08-28T02:05:22.8720000' AS DateTime2), CAST(N'2022-08-28T15:21:19.3890000' AS DateTime2), NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (36, 1, 1, N'I love you my love!', CAST(N'2022-08-28T13:49:30.7670000' AS DateTime2), CAST(N'2022-08-28T15:19:08.6040000' AS DateTime2), NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (37, 2, 3, N'Hey guys!!', CAST(N'2022-08-28T14:36:53.6810000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (38, 2, 5, N'Hey there!', CAST(N'2022-08-28T14:48:57.0190000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (39, 2, 5, N'Hi!', CAST(N'2022-08-28T14:50:06.7720000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (40, 3, 5, N'Hey! How are you?', CAST(N'2022-08-28T14:50:21.5290000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (41, 3, 2, N'PRIVET!', CAST(N'2022-08-28T15:09:12.4100000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (42, 1, 2, N'zdarov test1', CAST(N'2022-08-28T15:09:36.5940000' AS DateTime2), NULL, 3, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (43, 3, 2, N'PRIVET!', CAST(N'2022-08-28T15:10:40.2240000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (44, 1, 6, N'ZDAROV!', CAST(N'2022-08-28T15:11:30.3860000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (45, 1, 6, N'test13453535', CAST(N'2022-08-28T15:12:22.4570000' AS DateTime2), CAST(N'2022-08-28T15:14:13.2010000' AS DateTime2), NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (46, 1, 6, N'TI KRUTOI', CAST(N'2022-08-28T15:14:36.0450000' AS DateTime2), CAST(N'2022-08-28T15:15:02.5000000' AS DateTime2), NULL, 0)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (49, 2, 3, N'Privet!', CAST(N'2022-08-28T17:43:28.7010000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (50, 1, 3, N'Zdarova!', CAST(N'2022-08-28T17:47:04.0840000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (51, 2, 3, N'Kak dela?', CAST(N'2022-08-28T17:47:27.3280000' AS DateTime2), NULL, 1, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (53, 2, 1, N'Nikomu ne govori', CAST(N'2022-08-28T17:47:44.9320000' AS DateTime2), NULL, NULL, 0)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (56, 2, 1, N'Verni soobshenie', CAST(N'2022-08-28T17:50:31.5330000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (57, 1, 1, N'Privetik', CAST(N'2022-08-28T17:59:05.3540000' AS DateTime2), CAST(N'2022-08-28T18:00:06.5760000' AS DateTime2), NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (58, 1, 1, N'Pasdsadasd', CAST(N'2022-08-28T18:00:14.6880000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (59, 1, 1, N'rtueiuteiruteruity', CAST(N'2022-08-28T18:01:12.4930000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[Messages] ([Id], [UserId], [ChatId], [Value], [DateCreated], [DateLastEdited], [RepliedUserId], [VisibleToSender]) VALUES (60, 1, 3, N'Zdarov pacani', CAST(N'2022-08-28T18:04:17.6650000' AS DateTime2), CAST(N'2022-08-28T18:04:35.4180000' AS DateTime2), NULL, 0)
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password]) VALUES (1, N'test', N'test')
INSERT [dbo].[Users] ([Id], [Username], [Password]) VALUES (2, N'admin', N'admin')
INSERT [dbo].[Users] ([Id], [Username], [Password]) VALUES (3, N'test1', N'test1')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_ChatUser_UsersId]    Script Date: 8/28/2022 10:01:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ChatUser_UsersId] ON [dbo].[ChatUser]
(
	[UsersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_ChatId]    Script Date: 8/28/2022 10:01:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Messages_ChatId] ON [dbo].[Messages]
(
	[ChatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_RepliedUserId]    Script Date: 8/28/2022 10:01:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Messages_RepliedUserId] ON [dbo].[Messages]
(
	[RepliedUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_UserId]    Script Date: 8/28/2022 10:01:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Messages_UserId] ON [dbo].[Messages]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (CONVERT([bit],(0))) FOR [VisibleToSender]
GO
ALTER TABLE [dbo].[ChatUser]  WITH CHECK ADD  CONSTRAINT [FK_ChatUser_Chats_ChatsId] FOREIGN KEY([ChatsId])
REFERENCES [dbo].[Chats] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChatUser] CHECK CONSTRAINT [FK_ChatUser_Chats_ChatsId]
GO
ALTER TABLE [dbo].[ChatUser]  WITH CHECK ADD  CONSTRAINT [FK_ChatUser_Users_UsersId] FOREIGN KEY([UsersId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChatUser] CHECK CONSTRAINT [FK_ChatUser_Users_UsersId]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Chats_ChatId] FOREIGN KEY([ChatId])
REFERENCES [dbo].[Chats] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Chats_ChatId]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users_RepliedUserId] FOREIGN KEY([RepliedUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users_RepliedUserId]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [SimpleChatApp] SET  READ_WRITE 
GO
