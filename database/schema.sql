IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'YoutaiteDB')
    CREATE DATABASE YoutaiteDB;
GO

USE YoutaiteDB;
GO

-- Drop tables in reverse order (children before parents)
DROP TABLE IF EXISTS SingerInfo;
DROP TABLE IF EXISTS VocalExamples;
DROP TABLE IF EXISTS Socials;
DROP TABLE IF EXISTS CreatorLanguages;
DROP TABLE IF EXISTS Languages;
DROP TABLE IF EXISTS Creators;

-- 1. Creators Table
CREATE TABLE Creators (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    About NVARCHAR(1000),
    ProfilePictureUrl NVARCHAR(500),
    Equipment NVARCHAR(500)
);

-- 2. Languages Table
CREATE TABLE Languages (
    Id INT PRIMARY KEY IDENTITY(1,1),
    LanguageName NVARCHAR(50) NOT NULL
);

-- 3. CreatorLanguages (Bridge Table)
CREATE TABLE CreatorLanguages (
    CreatorId INT NOT NULL REFERENCES Creators(Id) ON DELETE CASCADE,
    LanguageId INT NOT NULL REFERENCES Languages(Id) ON DELETE CASCADE,
    PRIMARY KEY (CreatorId, LanguageId)
);

-- 4. Socials Table
CREATE TABLE Socials (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CreatorId INT NOT NULL REFERENCES Creators(Id) ON DELETE CASCADE,
    PlatformName NVARCHAR(50) NOT NULL,
    Url NVARCHAR(255) NOT NULL
);

-- 5. VocalExamples Table
CREATE TABLE VocalExamples (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CreatorId INT NOT NULL REFERENCES Creators(Id) ON DELETE CASCADE,
    Title NVARCHAR(200) NOT NULL,
    Url NVARCHAR(255) NOT NULL
);

-- 6. SingerInfo Table (One-to-one with Creators)
CREATE TABLE SingerInfo (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CreatorId INT NOT NULL UNIQUE REFERENCES Creators(Id) ON DELETE CASCADE,
    VoiceType NVARCHAR(50),
    RangeLow NVARCHAR(10),
    RangeHigh NVARCHAR(10)
);

GO

-- Seed Data
INSERT INTO Creators (Name, About, ProfilePictureUrl, Equipment)
VALUES 
    ('Rachie', 
    '🎀 hey everyone, rachie here! ⌒°(๑ • ᴗ ♥ ๑)°⌒ ♡  💌
    i''ve been making english covers of vocaloid songs since i was 13 or something as a way for my classmates to stop bullying me for listening to weeb songs.
    when I''m not making covers for YouTube, I stream as a vtuber!
    thanks for checking me out 💗', 
    'https://pbs.twimg.com/profile_images/2001407730699866113/uZESzpzu_400x400.jpg', 
    'Neumann U87'),
    ('Kuraiinu', 'A ghost dog, singing and making music with friends and vocal synths', 'https://static.wikia.nocookie.net/nicodougasingers/images/1/1b/Kuraiinu_Twitter_PFP.png/revision/latest?cb=20250802120938', 'Rode NT1');

INSERT INTO Languages (LanguageName)
VALUES ('Japanese'), ('English'), ('Korean'), ('Indonesian');

INSERT INTO CreatorLanguages (CreatorId, LanguageId)
VALUES (1, 2), (1, 4), (2, 1), (2, 2);

INSERT INTO Socials (CreatorId, PlatformName, Url)
VALUES 
    (1, 'YouTube', 'https://www.youtube.com/@rachie/'),
    (1, 'Twitter', 'https://x.com/splendiferachie'),
    (1, 'Twitch', 'https://www.twitch.tv/rachie'),
    (2, 'YouTube', 'https://www.youtube.com/@Kuraiinu'),
    (2, 'Twitter', 'https://x.com/_Kuraiinu'),
    (2, 'Patreon', 'https://www.patreon.com/Kuraiinu');

INSERT INTO SingerInfo (CreatorId, VoiceType, RangeLow, RangeHigh)
VALUES 
    (1, 'Soprano', 'A3', 'E6'),
    (2, 'Baritone', 'G3', 'C6');

INSERT INTO VocalExamples (CreatorId, Title, Url)
VALUES
    (1, 'Summersong Cover', 'https://www.youtube.com/watch?v=KgQ22VcamWc'),
    (2, 'Birdbrain Cover', 'https://www.youtube.com/watch?v=sZAaJa6J_iw');