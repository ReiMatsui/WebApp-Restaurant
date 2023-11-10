-- SQLite
-- SQLite
-- SQLite
CREATE TABLE Users (
    UserName TEXT NOT NULL,
    PhoneNumber TEXT NOT NULL,
    ReviewCount INTEGER,
    PRIMARY KEY (UserName, PhoneNumber),
    UNIQUE (UserName),
    UNIQUE (PhoneNumber)
);

INSERT INTO Users (UserName, PhoneNumber, ReviewCount)
VALUES
    ('田中 太郎', '555-1111', 5),
    ('山本 さちこ', '555-2222', 8),
    ('佐藤 一郎', '555-3333', 12),
    ('鈴木 由美', '555-4444', 7),
    ('高橋 健太', '555-5555', 3),
    ('渡辺 朋子', '555-6666', 10),
    ('斎藤 裕太', '555-7777', 6),
    ('伊藤 美穂', '555-8888', 9),
    ('中村 雄大', '555-9999', 15),
    ('小林 未来', '555-1010', 4),
    ('林 陽子', '555-2020', 11),
    ('山田 正人', '555-3030', 6),
    ('加藤 美晴', '555-4040', 8),
    ('木村 浩二', '555-5050', 10),
    ('松本 亜紀', '555-6060', 7),
    ('井上 剛', '555-7070', 14),
    ('佐々木 里香', '555-8080', 9),
    ('田村 勇樹', '555-9090', 13),
    ('山口 春美', '555-1212', 5),
    ('岡田 拓也', '555-2323', 12),
    ('中島 優子', '555-3434', 6),
    ('藤田 和也', '555-4545', 9),
    ('岸 朋美', '555-5656', 4),
    ('河野 啓介', '555-6767', 11),
    ('吉田 美香', '555-7878', 8),
    ('佐久間 大輔', '555-8989', 7),
    ('村上 真紀', '555-1011', 10),
    ('桜井 慎一', '555-1122', 5),
    ('大野 千鶴', '555-2233', 6),
    ('西田 昭彦', '555-3344', 8),
    ('森田 美奈', '555-4455', 9),
    ('杉山 彩', '555-5566', 12);


CREATE TABLE Restaurants (
    RestaurantID INTEGER PRIMARY KEY,
    RestaurantName TEXT,
    PhoneNumber TEXT,
    Address TEXT
);

CREATE TABLE Restaurants (RestaurantID INTEGER, RestaurantName VARCHAR(20), PhoneNumber VARCHAR(20), Addres VARCHAR(20), PRIMARY KEY (RestaurantID));



INSERT INTO Restaurants (RestaurantID,RestaurantName, PhoneNumber, Addres)
VALUES
    (1,'居酒屋 たんか', '03-1111-2222', '東京都新宿区1-1-1'),
    (2,'寿司 まぐろや', '06-2222-3333', '大阪府大阪市中央区2-2-2'),
    (3,'焼肉 こだわり家', '075-3333-4444', '京都府京都市東山区3-3-3'),
    (4,'ラーメン 一八', '092-4444-5555', '福岡県福岡市博多区4-4-4'),
    (5,'カフェ ゆり', '052-5555-6666', '愛知県名古屋市中村区5-5-5'),
    (6,'蕎麦 かずのこ', '011-6666-7777', '北海道札幌市中央区6-6-6'),
    (7,'うどん やまと', '082-7777-8888', '広島県広島市中区7-7-7'),
    (8,'焼き鳥 やまもと', '045-8888-9999', '神奈川県横浜市西区8-8-8'),
    (9,'イタリアン オリーブ', '089-9999-1010', '愛媛県松山市九州町9-9-9'),
    (10,'寿司 さくら', '098-1010-1111', '沖縄県那覇市10-10-10'),
    (11,'居酒屋 わかば', '03-1111-1212', '東京都渋谷区11-11-11'),
    (12,'おでん やすだ', '06-2222-1313', '大阪府梅田区12-12-12'),
    (13,'焼き肉 こだわり', '075-3333-1414', '京都府伏見区13-13-13'),
    (14,'カフェ ほんだ', '092-4444-1515', '福岡県博多市14-14-14'),
    (15,'寿司 やまさ', '052-5555-1616', '愛知県名古屋市中区15-15-15'),
    (16,'天ぷら かわもと', '011-6666-1717', '北海道札幌市北区16-16-16'),
    (17,'ラーメン やすもと', '082-7777-1818', '広島県広島市南区17-17-17'),
    (18,'居酒屋 たけし', '045-8888-1919', '神奈川県横浜市中区18-18-18'),
    (19,'寿司 まつもと', '089-9999-2020', '愛媛県松山市東区19-19-19');

CREATE TABLE RatingsDiscounts (
    UserName TEXT,
    RestaurantID INTEGER,
    Rating INTEGER,
    DiscountRate INTEGER,
    PRIMARY KEY (UserName, RestaurantID),
    FOREIGN KEY (UserName) REFERENCES Users(UserName),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- RatingsDiscounts テーブルにデータを挿入
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('田中 太郎', 1, 90, 10),
    ('山本 さちこ', 2, 85, 15),
    ('佐藤 一郎', 3, 78, 12),
    ('鈴木 由美', 4, 92, 8),
    ('高橋 健太', 5, 88, 12),
    ('渡辺 朋子', 6, 95, 5),
    ('斎藤 裕太', 7, 80, 20),
    ('伊藤 美穂', 8, 86, 14),
    ('中村 雄大', 9, 94, 6),
    ('小林 未来', 10, 75, 25);

-- レストランIDが1の店に対応するデータを生成
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('山本 さちこ', 1, 85, 15),
    ('佐藤 一郎', 1, 78, 12),
    ('鈴木 由美', 1, 92, 8),
    ('高橋 健太', 1, 88, 12);

-- レストランIDが2のレストランに関連する評価データを生成
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('桜井 慎一', 2, 65, 15),
    ('大野 千鶴', 2, 68, 10),
    ('西田 昭彦', 2, 85, 5),
    ('森田 美奈', 2, 92, 12),
    ('杉山 彩', 2, 37, 8);

-- レストランIDが3のレストランに関連する評価データを生成
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('林 陽子', 3, 71, 10),
    ('山田 正人', 3, 46, 15),
    ('加藤 美晴', 3, 68, 12),
    ('木村 浩二', 3, 70, 8),
    ('松本 亜紀', 3, 79, 12),
    ('井上 剛', 3, 84, 6),
    ('佐々木 里香', 3, 59, 10),
    ('田村 勇樹', 3, 78, 5),
    ('山口 春美', 3, 58, 20),
    ('岡田 拓也', 3, 72, 7);

-- レストランIDが4のレストランに関連する評価データを生成
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('藤田 和也', 4, 91, 10),
    ('岸 朋美', 4, 84, 15),
    ('河野 啓介', 4, 91, 12),
    ('斎藤 裕太', 4, 86, 8),
    ('伊藤 美穂', 4, 99, 12),
    ('中村 雄大', 4, 78, 5);

-- レストランIDが5のレストランに関連する評価データを生成
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('木村 浩二', 5, 100, 10),
    ('松本 亜紀', 5, 78, 15),
    ('井上 剛', 5, 64, 12),
    ('佐々木 里香', 5, 79, 8),
    ('田村 勇樹', 5, 83, 12),
    ('山口 春美', 5, 58, 10),
    ('岡田 拓也', 5, 72, 6),
    ('中島 優子', 5, 96, 10),
    ('藤田 和也', 5, 91, 15),
    ('岸 朋美', 5, 84, 8),
    ('河野 啓介', 5, 61, 12),
    ('吉田 美香', 5, 98, 10);

-- レストランIDが6のレストランに関連する評価データを生成
INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('田中 太郎', 6, 55, 10),
    ('山本 さちこ', 6, 68, 15),
    ('佐藤 一郎', 6, 52, 12),
    ('鈴木 由美', 6, 47, 8),
    ('高橋 健太', 6, 53, 12),
    ('斎藤 裕太', 6, 66, 10),
    ('伊藤 美穂', 6, 69, 15),
    ('中村 雄大', 6, 55, 8);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('林 陽子', 7, 11, 15),
    ('山田 正人', 7, 6, 10),
    ('加藤 美晴', 7, 8, 20),
    ('木村 浩二', 7, 10, 25),
    ('松本 亜紀', 7, 7, 15),
    ('井上 剛', 7, 14, 30),
    ('佐々木 里香', 7, 9, 20),
    ('田村 勇樹', 7, 13, 25),
    ('山口 春美', 7, 5, 10),
    ('山口 春美', 15, 65, 9),
    ('岡田 拓也', 15, 52, 18),
    ('中島 優子', 15, 65, 10),
    ('藤田 和也', 15, 59, 13),
    ('伊藤 美穂', 15, 69, 13);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('渡辺 朋子', 16, 80, 15),
    ('斎藤 裕太', 16, 86, 10),
    ('伊藤 美穂', 16, 79, 13),
    ('中村 雄大', 16, 75, 25),
    ('佐久間 大輔', 16, 78, 11),
    ('村上 真紀', 16, 80, 15),
    ('桜井 慎一', 16, 85, 9),
    ('大野 千鶴', 16, 76, 10);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('高橋 健太', 17, 43, 5),
    ('渡辺 朋子', 17, 40, 15),
    ('岡田 拓也', 17, 42, 20),
    ('中島 優子', 17, 46, 10),
    ('藤田 和也', 17, 29, 15),
    ('岸 朋美', 17, 34, 6);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('斎藤 裕太', 18, 96, 0),
    ('伊藤 美穂', 18, 97, 0),
    ('中村 雄大', 18, 95, 0),
    ('小林 未来', 18, 94, 0),
    ('林 陽子', 18, 93, 0),
    ('山田 正人', 18, 96, 0);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('佐々木 里香', 19, 39, 3),
    ('田村 勇樹', 19, 33, 6),
    ('山口 春美', 19, 45, 7),
    ('岡田 拓也', 19, 52, 7),
    ('中島 優子', 19, 56, 4),
    ('藤田 和也', 19, 49, 3),
    ('岸 朋美', 19, 44, 3),
    ('河野 啓介', 19, 78, 4);


CREATE TABLE Rankings (
    RestaurantID INTEGER,
    RegionName TEXT,
    Ranking INTEGER,
    PRIMARY KEY (RestaurantID, RegionName),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

INSERT INTO Rankings (RestaurantID, RegionName, Ranking) VALUES
    (1, '関東', 1),
    (11, '関東', 3),
    (2, '関西', 2),
    (12, '関西', 1),
    (3, '関西', 3),
    (13, '関西', 2),
    (4, '九州', 1),
    (14, '九州', 3),
    (5, '中部', 2),
    (15, '中部', 1),
    (6, '東北・北海道', 3),
    (16, '東北・北海道', 2),
    (7, '中国・四国', 2),
    (17, '中国・四国', 1),
    (8, '関東', 3),
    (18, '関東', 2),
    (9, '中国・四国', 1),
    (19, '中国・四国', 3),
    (10, '九州・沖縄', 2);
    ('岡田 拓也', 7, 12, 20);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('西田 昭彦', 8, 78, 10),
    ('森田 美奈', 8, 89, 12),
    ('杉山 彩', 8, 82, 15),
    ('斎藤 裕太', 8, 86, 10),
    ('村上 真紀',8, 10, 15),
    ('桜井 慎一', 8, 75, 8),
    ('大野 千鶴', 8, 68, 10),
    ('中村 雄大', 8, 75, 20);


INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('井上 剛', 9, 84, 20),
    ('佐々木 里香', 9, 89, 15),
    ('田村 勇樹', 9, 83, 18),
    ('山口 春美', 9, 85, 10),
    ('斎藤 裕太', 9, 86, 12),
    ('伊藤 美穂', 9, 89, 15),
    ('小林 未来', 9, 94, 8),
    ('林 陽子', 9, 91, 18),
    ('山田 正人', 9,96, 12);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('渡辺 朋子', 10, 90, 15),
    ('斎藤 裕太', 10, 76, 10),
    ('伊藤 美穂', 10, 89, 15),
    ('中村 雄大', 10, 85, 20),
    ('吉田 美香', 10, 87, 12),
    ('佐久間 大輔', 10, 77, 10),
    ('村上 真紀', 10, 20, 15),
    ('桜井 慎一', 10, 75, 8),
    ('大野 千鶴', 10, 86, 10);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('田中 太郎', 11, 45, 10),
    ('山本 さちこ', 11, 58, 12),
    ('佐藤 一郎', 11, 62, 15),
    ('鈴木 由美', 11, 47, 11),
    ('高橋 健太', 11, 43, 5),
    ('渡辺 朋子', 11, 60, 14),
    ('斎藤 裕太', 11, 63, 10),
    ('伊藤 美穂', 11, 59, 15),
    ('中村 雄大', 11, 55, 20),
    ('小林 未来', 11, 54, 8);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('藤田 和也', 12, 79, 12),
    ('岸 朋美', 12, 74, 8),
    ('河野 啓介', 12, 71, 15),
    ('吉田 美香', 12, 68, 12),
    ('佐久間 大輔', 12, 77, 10),
    ('村上 真紀', 12, 60, 14),
    ('桜井 慎一', 12, 75, 9),
    ('大野 千鶴', 12, 67, 10),
    ('西田 昭彦', 12, 62, 12),
    ('森田 美奈', 12, 59, 13);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('岸 朋美', 13, 64, 8),
    ('河野 啓介', 13, 61, 15),
    ('吉田 美香', 13, 68, 12),
    ('佐久間 大輔', 13, 47, 10),
    ('小林 未来', 13, 74, 9),
    ('林 陽子', 13, 61, 14),
    ('山田 正人', 13, 67, 12),
    ('加藤 美晴', 13, 81, 13);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('加藤 美晴', 14, 78, 12),
    ('木村 浩二', 14, 80, 15),
    ('松本 亜紀', 14, 71, 11),
    ('井上 剛', 14, 64, 20),
    ('佐々木 里香', 14, 79, 13),
    ('斎藤 裕太', 14, 66, 10),
    ('伊藤 美穂', 14, 79, 13),
    ('中村 雄大', 14, 85, 25),
    ('小林 未来', 14, 74, 8);

INSERT INTO RatingsDiscounts (UserName, RestaurantID, Rating, DiscountRate)
VALUES
    ('木村 浩二', 15, 60, 15),
    ('松本 亜紀', 15, 57, 11),
    ('井上 剛', 15, 54, 20),
    ('佐々木 里香', 15, 59, 13),
    ('田村 勇樹', 15, 63, 19);


SELECT UserName, PhoneNumber, ReviewCount
FROM Users
WHERE ReviewCount >= 10;

SELECT *
FROM Restaurants
NATURAL JOIN RatingsDiscounts;


SELECT UserName
FROM RatingsDiscounts
WHERE Rating >= 95
UNION
SELECT UserName
FROM RatingsDiscounts
WHERE Rating <= 20;

SELECT UserName
FROM RatingsDiscounts
EXCEPT
SELECT UserName
FROM RatingsDiscounts
WHERE Rating <= 20;

SELECT DISTINCT UserName
FROM RatingsDiscounts

SELECT AVG(Rating),RestaurantName
FROM (RatingsDiscounts NATURAL JOIN Restaurants)
WHERE RestaurantID = 5



SELECT Restaurants.RestaurantName, AVG(RatingsDiscounts.Rating) AS AverageRating
FROM Restaurants
JOIN RatingsDiscounts ON Restaurants.RestaurantID = RatingsDiscounts.RestaurantID
GROUP BY Restaurants.RestaurantName;


SELECT RestaurantName
FROM Restaurants
WHERE RestaurantID = (
    SELECT RestaurantID
    FROM (
        SELECT RestaurantID, AVG(Rating) AS AvgRating
        FROM RatingsDiscounts
        GROUP BY RestaurantID
    ) AS Subquery
    WHERE AvgRating = (
        SELECT MAX(AvgRating)
        FROM (
            SELECT AVG(Rating) AS AvgRating
            FROM RatingsDiscounts
            GROUP BY RestaurantID
        ) AS MaxSubquery
    )
);


SELECT RestaurantName, Rating
FROM Restaurants
JOIN RatingsDiscounts ON Restaurants.RestaurantID = RatingsDiscounts.RestaurantID
ORDER BY Rating DESC;

UPDATE Users
SET PhoneNumber = '555-2929'
WHERE UserName= '田中 太郎';

SELECT Restaurants.RestaurantName, AVG(RatingsDiscounts.Rating) AS AverageRating
FROM Restaurants
JOIN RatingsDiscounts ON Restaurants.RestaurantID = RatingsDiscounts.RestaurantID
GROUP BY Restaurants.RestaurantName
ORDER BY AverageRating DESC;

CREATE VIEW UserRatingsDiscounts AS
SELECT Users.UserName, RatingsDiscounts.Rating, RatingsDiscounts.DiscountRate
FROM (Users NATURAL JOIN RatingsDiscounts ON Users.UserName = RatingsDiscounts.UserName);

CREATE VIEW AverageRatings AS
SELECT Restaurants.RestaurantName, AVG(RatingsDiscounts.Rating) AS AverageRating
FROM Restaurants
JOIN RatingsDiscounts ON Restaurants.RestaurantID = RatingsDiscounts.RestaurantID
GROUP BY Restaurants.RestaurantName;


-- 主キーであるRestaurantIDにクラスタ化インデックスを作成
CREATE UNIQUE CLUSTERED INDEX idx_Restaurant_RestaurantID ON Restaurant (RestaurantID);

-- PhoneNumberとRestaurantNameに非クラスタ化B-Treeインデックスを作成
CREATE INDEX idx_Restaurant_PhoneNumber ON Restaurant (PhoneNumber);
CREATE INDEX idx_Restaurant_RestaurantName ON Restaurant (RestaurantName);


-- 主キーであるUserNameとRestaurantIDにクラスタ化インデックスを作成
CREATE UNIQUE CLUSTERED INDEX idx_RatingDiscounts_UserName_RestaurantID ON RatingDiscounts (UserName, RestaurantID);

-- RatingとDiscountRateに非クラスタ化B-Treeインデックスを作成
CREATE INDEX idx_RatingDiscounts_Rating ON RatingDiscounts (Rating);
CREATE INDEX idx_RatingDiscounts_DiscountRate ON RatingDiscounts (DiscountRate);

-- 外部キー制約によるインデックス（ユーザー名とレストランIDに関連する外部キー制約インデックス）
-- これはSQLiteの外部キー制約を作成する際に自動的に生成される場合もあります


-- 主キーであるUserNameとRestaurantIDにクラスタ化インデックスを作成
CREATE UNIQUE CLUSTERED INDEX idx_RatingDiscounts_UserName_RestaurantID ON RatingDiscounts (UserName, RestaurantID);

-- RatingとDiscountRateに非クラスタ化B-Treeインデックスを作成
CREATE INDEX idx_RatingDiscounts_Rating ON RatingDiscounts (Rating);
CREATE INDEX idx_RatingDiscounts_DiscountRate ON RatingDiscounts (DiscountRate);

-- 外部キー制約によるインデックス（ユーザー名とレストランIDに関連する外部キー制約インデックス）
-- これはSQLiteの外部キー制約を作成する際に自動的に生成される場合もあります


-- 主キーであるRegionNameとRestaurantIDにクラスタ化インデックスを作成
CREATE UNIQUE CLUSTERED INDEX idx_Rankings_RegionName_RestaurantID ON Rankings (RegionName, RestaurantID);

-- RankingsテーブルにR-Treeインデックスを設定（SQLiteはR-Treeをサポートしている場合があります）
-- 注意: SQLiteがR-Treeをサポートしていない場合、他のデータベースシステムを検討してください。
