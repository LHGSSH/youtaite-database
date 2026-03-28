IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'YoutaiteDB')
    CREATE DATABASE YoutaiteDB;
GO

USE YoutaiteDB;
GO

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