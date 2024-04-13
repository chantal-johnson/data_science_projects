--select *
--from CyclisticCaseStudy..[202201_tripdata]

-- edited table for use
SELECT
member_casual, rideable_type, 
started_at, DATENAME(month,started_at) AS start_month, DATENAME(weekday,started_at) AS start_day, DATENAME(hour,started_at) AS start_hour,
ended_at, DATENAME(month,ended_at) AS end_month, DATENAME(weekday,ended_at) AS end_day, DATENAME(hour,ended_at) AS end_hour,
DATEDIFF(mi,started_at,ended_at) AS ride_duration,
start_lat, start_lng, end_lat, end_lng
FROM CyclisticCaseStudy..[202201_tripdata]

-- Shows total number of members by membership
SELECT member_casual, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY member_casual

-- Shows ride breakdown by month / membership
SELECT member_casual,DATENAME(month,started_at) AS start_month, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY DATENAME(month,started_at), member_casual
ORDER BY DATENAME(month,started_at)

-- Shows ride breakdown by day / membership
SELECT member_casual,DATENAME(WEEKDAY,started_at) AS start_day, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY DATENAME(WEEKDAY,started_at), member_casual
ORDER BY DATENAME(WEEKDAY,started_at)

-- Shows ride breakdown by month / day/ membership
SELECT member_casual,DATENAME(month,started_at) AS start_month, DATENAME(WEEKDAY,started_at) AS start_day, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY DATENAME(month,started_at), DATENAME(WEEKDAY,started_at), member_casual
ORDER BY DATENAME(month,started_at), DATENAME(WEEKDAY,started_at)

-- Shows average ride duration
SELECT member_casual, AVG(DATEDIFF(mi,started_at,ended_at)) AS ride_duration_minutes
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY member_casual

-- Shows average ride duration by day
SELECT member_casual, DATENAME(WEEKDAY,started_at) AS start_day, AVG(DATEDIFF(mi,started_at,ended_at)) AS ride_duration_minutes
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY DATENAME(WEEKDAY,started_at), member_casual
ORDER BY DATENAME(WEEKDAY,started_at)

-- Shows average ride duration by month
SELECT member_casual, DATENAME(MONTH,started_at) AS start_month, AVG(DATEDIFF(mi,started_at,ended_at)) AS ride_duration_minutes
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY DATENAME(MONTH,started_at), member_casual
ORDER BY DATENAME(MONTH,started_at)
-- above month / day
SELECT member_casual, DATENAME(MONTH,started_at) AS start_month, DATENAME(WEEKDAY,started_at) AS start_day, 
AVG(DATEDIFF(mi,started_at,ended_at)) AS ride_duration_minutes
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY DATENAME(MONTH,started_at), DATENAME(WEEKDAY,started_at), member_casual
ORDER BY DATENAME(MONTH,started_at), DATENAME(WEEKDAY,started_at)

--Showing rows with ride dates swapped by mistake (error fixed)
select *, DATEDIFF(mi,started_at,ended_at) AS ride_duration_minutes
from CyclisticCaseStudy..[202201_tripdata]
where DATEDIFF(mi,started_at,ended_at) < 0
order by DATEDIFF(mi,started_at,ended_at)

-- Swapping incorrect ride dates
UPDATE CyclisticCaseStudy..[202201_tripdata]
SET started_at=ended_at, ended_at=started_at
WHERE DATEDIFF(mi,started_at,ended_at) < 0

--Showing breakdown of bike type used
SELECT rideable_type, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY rideable_type
-- Showing above by membership
SELECT rideable_type, member_casual, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY member_casual, rideable_type

-- Showing breakdown on bike type / month / day
SELECT member_casual, rideable_type, DATENAME(MONTH,started_at) AS start_month, DATENAME(WEEKDAY,started_at) AS start_day, COUNT(member_casual) AS ride_count
FROM CyclisticCaseStudy..[202201_tripdata]
GROUP BY member_casual, rideable_type, DATENAME(MONTH,started_at), DATENAME(WEEKDAY,started_at)
ORDER BY member_casual, rideable_type

-- breakdown of num of rides by hour
select DATENAME(hour,started_at) AS start_hour, COUNT(member_casual) AS ride_count
from CyclisticCaseStudy..[202202_tripdata]
GROUP BY DATENAME(hour,started_at)
ORDER BY COUNT(member_casual) DESC

-- by day and hour
select DATENAME(weekday,started_at) AS start_day, DATENAME(hour,started_at) AS start_hour, COUNT(member_casual) AS ride_count
from CyclisticCaseStudy..[202202_tripdata]
GROUP BY DATENAME(weekday,started_at), DATENAME(hour,started_at)
ORDER BY COUNT(member_casual) DESC

-- by hour and mem type
select DATENAME(hour,started_at) AS start_hour, member_casual, COUNT(member_casual) AS ride_count
from CyclisticCaseStudy..[202202_tripdata]
GROUP BY member_casual, DATENAME(hour,started_at)
ORDER BY COUNT(member_casual) DESC

-- by day / hour / mem type
select member_casual, DATENAME(weekday,started_at) AS start_day, DATENAME(hour,started_at) AS start_hour, COUNT(member_casual) AS ride_count
from CyclisticCaseStudy..[202202_tripdata]
GROUP BY member_casual, DATENAME(weekday,started_at), DATENAME(hour,started_at)
ORDER BY COUNT(member_casual) DESC

-- number of ride lasting over 24hrs
SELECT member_casual, COUNT(member_casual) AS ride_count, AVG(DATEDIFF(mi,started_at,ended_at)) AS ride_duration_minutes
FROM CyclisticCaseStudy..[202201_tripdata]
WHERE DATEDIFF(mi,started_at,ended_at) > 1400
GROUP BY member_casual

