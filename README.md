# 🏡 Airbnb NYC SQL Analytics Dashboard 📈

> A data-driven SQL analysis project uncovering trends, pricing insights, and optimization opportunities in the New York City Airbnb market.

---

## 🌐 Project Overview
This project analyzes the Airbnb NYC 2019 dataset using SQL to surface insights on pricing, demand hotspots, host performance, and missed business potential. It aims to guide marketing, pricing, and operational decisions with evidence-based metrics.

---

## ⚙️ Tech Stack & Tools
- **Database:** MySQL
- **Language:** SQL
- **Tools:** MySQL Workbench, VS Code, GitHub

---

## 🧱 Database Schema
```sql
CREATE TABLE ab_nyc_2019 (
    id INT,
    name VARCHAR(255),
    host_id INT,
    host_name VARCHAR(255),
    neighbourhood_group VARCHAR(100),
    neighbourhood VARCHAR(100),
    latitude FLOAT,
    longitude FLOAT,
    room_type VARCHAR(50),
    price INT,
    minimum_nights INT,
    number_of_reviews INT,
    availability_365 INT
);
```

---

## 🔍 Analysis Features (SQL Views)

### 1. 🗺️ Highest Demand by Area
```sql
CREATE VIEW highest_demand_by_area AS
SELECT neighbourhood_group, room_type, COUNT(*) AS total_bookings
FROM ab_nyc_2019
GROUP BY neighbourhood_group, room_type
ORDER BY total_bookings DESC;
```
> Identifies areas and room types with the highest demand for marketing focus.

### 2. 🧑‍💼 Top Hosts by Listings
```sql
CREATE VIEW top_hosts_by_listings AS
SELECT host_id, host_name, COUNT(*) AS listings_count
FROM ab_nyc_2019
GROUP BY host_id, host_name
ORDER BY listings_count DESC
LIMIT 10;
```
> Finds hosts with the most listings, indicating strong potential for scaling.

### 3. 💸 Most Expensive Neighborhoods
```sql
CREATE VIEW top_expensive_neighbourhoods AS
SELECT neighbourhood, AVG(price) AS avg_price
FROM ab_nyc_2019
GROUP BY neighbourhood
ORDER BY avg_price DESC
LIMIT 5;
```
> Lists the top 5 priciest neighborhoods based on average price.

### 4. 📉 Underpriced Listings
```sql
CREATE VIEW underpriced_listings AS
SELECT t1.id, t1.neighbourhood, t1.price, AVG(t2.price) AS avg_area_price
FROM ab_nyc_2019 t1
JOIN ab_nyc_2019 t2 
  ON t1.neighbourhood = t2.neighbourhood 
  AND t1.id != t2.id
GROUP BY t1.id, t1.neighbourhood, t1.price
HAVING t1.price < AVG(t2.price) * 0.8;
```
> Identifies listings priced significantly below neighborhood averages.

### 5. 🏷️ Price Factor Analysis
```sql
CREATE VIEW price_factors_analysis AS
SELECT room_type, minimum_nights, availability_365, 
       ROUND(AVG(price), 2) AS avg_price, 
       COUNT(*) AS listings
FROM ab_nyc_2019
WHERE price BETWEEN 10 AND 1000
GROUP BY room_type, minimum_nights, availability_365
ORDER BY avg_price DESC
LIMIT 10;
```
> Analyzes how availability, room type, and stay duration affect prices.

### 6. 🌟 High Reviews & Low Prices
```sql
CREATE VIEW highly_reviewed_but_low_price AS
SELECT id, name, neighbourhood, price, number_of_reviews
FROM ab_nyc_2019
WHERE number_of_reviews > 100 AND price < 70
ORDER BY number_of_reviews DESC;
```
> Highlights popular but affordable listings with strong review counts.

### 7. 📭 Under-reviewed High Availability
```sql
CREATE VIEW under_reviewed_high_availability AS
SELECT neighbourhood, COUNT(*) AS available_listings
FROM ab_nyc_2019
WHERE availability_365 > 200 AND number_of_reviews < 5
GROUP BY neighbourhood
ORDER BY available_listings DESC;
```
> Shows neighborhoods with available inventory but low visibility.

---

## 📌 Key Insights
- Manhattan and Brooklyn dominate demand across all room types.
- Some hosts manage over 200 listings, ideal for partnership programs.
- Several listings are underpriced by more than 20% vs. local averages.
- Highly-reviewed affordable listings offer high value to guests.
- Dozens of properties have >200 days available but are rarely reviewed.

---

## 📈 Strategic Recommendations
1. Increase marketing in high-demand zones like Brooklyn Private Rooms.
2. Target top hosts for premium support and loyalty programs.
3. Flag underpriced listings for potential revenue optimization.
4. Promote highly-reviewed but low-priced listings to budget travelers.
5. Investigate under-reviewed properties with high availability.
6. Use pricing factors analysis to optimize dynamic pricing strategies.
7. Encourage new guests to review to improve listing visibility.

---

## 🚀 Installation Instructions
```sql
CREATE DATABASE Airbnb;
USE Airbnb;
-- Execute all CREATE VIEW scripts
```
> Ensure you have MySQL installed and the Airbnb NYC 2019 dataset imported.

---

## 🔮 Further Development
- Integrate calendar-based availability analytics.
- Visualize pricing heatmaps with GIS tools.
- Add sentiment analysis from guest reviews.
- Build dashboards with Power BI or Tableau.
- Develop a recommender system for hosts.

---

## 👨‍💻 Author & License
**Author:** Navanil Das  
📧 navanildas2702@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/navanil-das-a67836166/)  

📄 **License:** MIT

---
