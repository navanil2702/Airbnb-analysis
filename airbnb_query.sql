Create Database Airbnb;
Use Airbnb;

#1. Where should we focus our marketing based on highest demand?
CREATE VIEW highest_demand_by_area AS
SELECT neighbourhood_group, room_type, COUNT(*) AS total_bookings
FROM ab_nyc_2019
GROUP BY neighbourhood_group, room_type
ORDER BY total_bookings DESC;

#2. Which hosts have the most listings (scaling potential)?
CREATE VIEW top_hosts_by_listings AS
SELECT host_id, host_name, COUNT(*) AS listings_count
FROM ab_nyc_2019
GROUP BY host_id, host_name
ORDER BY listings_count DESC
LIMIT 10;

#3. What are the top 5 most expensive neighborhoods?
CREATE VIEW top_expensive_neighbourhoods AS
SELECT neighbourhood, AVG(price) AS avg_price
FROM ab_nyc_2019
GROUP BY neighbourhood
ORDER BY avg_price DESC
LIMIT 5;

#4. Where are hosts underpricing compared to similar listings nearby?
CREATE VIEW underpriced_listings AS
SELECT t1.id, t1.neighbourhood, t1.price, AVG(t2.price) AS avg_area_price
FROM ab_nyc_2019 t1
JOIN ab_nyc_2019 t2 
  ON t1.neighbourhood = t2.neighbourhood 
  AND t1.id != t2.id
GROUP BY t1.id, t1.neighbourhood, t1.price
HAVING t1.price < AVG(t2.price) * 0.8;

#5.  What amenities correlate with higher prices?
CREATE VIEW price_factors_analysis AS
SELECT room_type, minimum_nights, availability_365, 
       ROUND(AVG(price), 2) AS avg_price, 
       COUNT(*) AS listings
FROM ab_nyc_2019
WHERE price BETWEEN 10 AND 1000
GROUP BY room_type, minimum_nights, availability_365
ORDER BY avg_price DESC
LIMIT 10;

#6. Where are properties highly reviewed but priced low?
CREATE VIEW highly_reviewed_but_low_price AS
SELECT id, name, neighbourhood, price, number_of_reviews
FROM ab_nyc_2019
WHERE number_of_reviews > 100 AND price < 70
ORDER BY number_of_reviews DESC;

#7. Where is inventory available but under-reviewed (missed potential)?
CREATE VIEW under_reviewed_high_availability AS
SELECT neighbourhood, COUNT(*) AS available_listings
FROM ab_nyc_2019
WHERE availability_365 > 200 AND number_of_reviews < 5
GROUP BY neighbourhood
ORDER BY available_listings DESC;

# Retrieve all answers

SELECT * FROM highest_demand_by_area;
SELECT * FROM top_hosts_by_listings;
SELECT * FROM top_expensive_neighbourhoods;
SELECT * FROM underpriced_listings;
SELECT * FROM price_factors_analysis;
SELECT * FROM highly_reviewed_but_low_price;
SELECT * FROM under_reviewed_high_availability;






