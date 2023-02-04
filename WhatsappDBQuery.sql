-- Create the database
CREATE DATABASE WhatsApp;


-- Use the database
USE WhatsApp;


-- Create the Users table
CREATE TABLE Users (
UserId INT PRIMARY KEY IDENTITY(1,1),
UserName VARCHAR(50) NOT NULL,
PhoneNumber VARCHAR(20) UNIQUE NOT NULL,
ProfilePicture VARCHAR(255) NOT NULL,
CreatedDate DATETIME NOT NULL
);


-- Populate the Users table with 5 users
INSERT INTO Users (UserName, PhoneNumber, ProfilePicture, CreatedDate)
VALUES 
('Joshua', '+234 11 111 111', 'https://userspics.com/Joshua', GETDATE()),
('Janet', '+234 22 222 222', 'https://userspics.com/Janet', GETDATE()),
('Michael', '+234 33 333 333', 'https://userspics.com/Michael', GETDATE()),
('Adeleke', '+234 44 444 444', 'https://userspics.com/Adeleke', GETDATE()),
('Wale', '+234 55 555 555', 'https://userspics.com/Wale', GETDATE());


-- Create the Chats table
CREATE TABLE Chats (
ChatId INT PRIMARY KEY IDENTITY(1,1),
ChatName VARCHAR(100) NOT NULL,
CreatedDate DATETIME NOT NULL
);


-- Populate the Chats table with 2 chats
INSERT INTO Chats (ChatName, CreatedDate)
VALUES 
('Family Group', GETDATE()),
('Friends Group', GETDATE());


-- Create the Messages table
CREATE TABLE Messages (
MessageId INT PRIMARY KEY IDENTITY(1,1),
ChatId INT NOT NULL,
SenderId INT NOT NULL,
ReceiverId INT NOT NULL,
MessageText VARCHAR(MAX) NOT NULL,
SentDate DATETIME NOT NULL,
FOREIGN KEY (ChatId) REFERENCES Chats(ChatId),
FOREIGN KEY (SenderId) REFERENCES Users(UserId),
FOREIGN KEY (ReceiverId) REFERENCES Users(UserId)
);


-- Populate the Messages table with 5 messages
INSERT INTO Messages (ChatId, SenderId, ReceiverId, MessageText, SentDate)
VALUES 
(1, 1, 2, 'Hello Janet!', GETDATE()),
(1, 2, 3, 'Hi Michael!', GETDATE()),
(1, 3, 4, 'Whats up Adeleke?', GETDATE()),
(2, 5, 1, 'Hi Joshua, Are u back from Airport?', GETDATE()),
(2, 1, 5, 'Yes Wale, I am back!', GETDATE());


-- Query to view Sender Name, Receiver Name, Messages, Date Sent
SELECT
	sender.PhoneNumber AS SenderNumber,
    sender.UserName AS SenderName, 
    receiver.UserName AS ReceiverName, 
    msg.MessageText, 
    msg.SentDate
FROM Messages msg
JOIN Users sender ON msg.SenderId = sender.UserId
JOIN Users receiver ON msg.ReceiverId = receiver.UserId;
