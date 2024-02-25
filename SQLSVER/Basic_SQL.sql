create database data1
USE data1

-- CREATE TABLE grid (
--     gril_id INT,
--     DESCRIPTION VARCHAR(100),
--     event_year int,
--     event_data date,
--     restore_data varchar(10),
--     nerc_region VARCHAR(10),
--     demand_lose_mv VARCHAR(10),
--     affected_customers VARCHAR(10)
-- );

-- CREATE TABLE album(
--     album_id INT,
--     title VARCHAR(100),
--     artist_id INT
-- );

EXEC sp_rename 'discription', 'description'

BULK INSERT grid 
FROM 'G:\My Drive\DBMS\dbms\CSV\grid.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)

BULK INSERT album 
FROM 'G:\My Drive\DBMS\dbms\CSV\album.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)


UPDATE grid  
SET demand_lose_mv = NULL 
WHERE demand_lose_mv = 'null'

ALTER TABLE grid 
ALTER COLUMN demand_lose_mv INT



UPDATE grid  
SET affected_customers = NULL 
WHERE affected_customers = 'null'

ALTER TABLE grid 
ALTER COLUMN affected_customers INT;



SELECT * FROM grid


SELECT SUM(g.demand_lose_mv) AS MRO_Demand_lose 
FROM grid as g;

SELECT COUNT(gril_id) AS RFC_count
FROM grid
WHERE nerc_region = 'RFC'

SELECT MIN(affected_customers) AS min_affected_customers
FROM grid
WHERE demand_lose_mv is not NULL

SELECT MAX(affected_customers) AS max_affected_customers
FROM grid
WHERE demand_lose_mv  IS NOT NULL;

SELECT AVG(affected_customers) AS avg_affected_customers
FROM grid
WHERE demand_lose_mv IS NOT NULL

SELECT DESCRIPTION, LEN(DESCRIPTION) AS discription_length  
FROM grid

SELECT nerc_region, SUM(demand_lose_mv) AS demand_lose
FROM grid
WHERE demand_lose_mv IS NOT NULL
GROUP BY nerc_region
HAVING SUM(demand_lose_mv) > 10000
ORDER BY demand_lose DESC;


CREATE TABLE eurovision(
    euro_id INT,
    event_year DATE,
    country VARCHAR(30),
    gender VARCHAR(10),
    group_type VARCHAR(10),
    place INT,
    points INT,
    host_country VARCHAR(10),
    host_region VARCHAR(10),
    is_final TINYINT,
    sf_number TINYINT,
    song_in_english TINYINT
);

ALTER TABLE dbo.eurovision
ALTER COLUMN sf_number VARCHAR(10);

BULK INSERT eurovision 
FROM 'G:\My Drive\DBMS\dbms\CSV\eurovision.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)

SELECT * FROM dbo.eurovision;


CREATE TABLE artist(
    artist_id INT,
    name VARCHAR(100)
);

BULK INSERT artist 
FROM 'G:\My Drive\DBMS\dbms\CSV\artist.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
);

CREATE TABLE invoice(
    invoice_id INT,
    customer_id INT,
    invoice_Date DATETIME,
    billing_address VARCHAR(100),
    billing_city VARCHAR(50),
    billing_state VARCHAR(10),
    billing_country VARCHAR(50),
    billing_postalcode VARCHAR(30),
    total FLOAT

);


BULK INSERT invoice 
FROM 'G:\My Drive\DBMS\dbms\CSV\invoice.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
);


CREATE TABLE invoiceline(
    invoiceline_id INT,
    invoice_id INT,
    track_id INT,
    unit_price FLOAT,
    quantity INT
);

BULK INSERT invoiceline 
FROM 'G:\My Drive\DBMS\dbms\CSV\invoiceline.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
);

CREATE TABLE songlist(
    songlistID INT,
    song VARCHAR(40),
    artist VARCHAR(30),
    release_year INT,
    combined VARCHAR(100)
);

ALTER TABLE dbo.songlist
ALTER COLUMN release_year VARCHAR(10);


ALTER TABLE dbo.songlist
ALTER COLUMN song VARCHAR(70);

ALTER TABLE dbo.songlist
ALTER COLUMN artist VARCHAR(70);


BULK INSERT songlist 
FROM 'G:\My Drive\DBMS\dbms\CSV\songlist.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
);


CREATE TABLE track(
    track_id INT,
    name VARCHAR(50),
    album_id INT,
    mediatype_id SMALLINT,
    genre_id SMALLINT,
    composer VARCHAR(100),
    milliseconds INT,
    bytes INT,
    unit_price FLOAT
);

ALTER TABLE dbo.track
ALTER COLUMN name VARCHAR(150);

ALTER TABLE dbo.track
ALTER COLUMN composer VARCHAR(200);

BULK INSERT track 
FROM 'G:\My Drive\DBMS\dbms\CSV\track.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
);












