# PROD-2024-ENERGY-ANALYSIS

# 📖 Overview
This project combines SQL Server queries and Excel dashboards to analyze oil, gas, and water production data.
It demonstrates how to transform raw well production records into actionable insights using ranking queries, aggregations, and interactive visualizations.

# 📂 Dataset Description
The dataset includes detailed attributes for each well:

# Column	Description
API_WellNo	Unique well identifier
COUNTY	County location
CoName	Operating company
HOLE	Original bore details
SIDETRACK	Sidetrack bore info
COMPLETION	Completion status/date
WELL TYPE	Type of well (oil, gas, water)
FIELD	Field name
WL STATUS	Well status (active/inactive)
WELL NM	Well name
TOWN	Town location
PROD FORM	Production formation
MONTHPROD	Month of production
GASPROD	Gas production volume
WATERPROD	Water production volume
OILPROD	Oil production volume
YEAR	Year of production

#✨ Insights & Features
📊 Production Trends: Oil, gas, and water totals by month

🏆 Ranking: Top wells, companies, and counties by production

🔄 Lifecycle Analysis: Completion → current well status

📈 Ratios: Gas-to-oil and water-to-oil ratios

🎛 Interactive Excel Dashboard: PivotTables, slicers, charts, combo charts,line charts and pie charts

# 📊 Example SQL Queries
1. Total Production by Year
sql
SELECT YEAR,
       SUM(OILPROD) AS TotalOil,
       SUM(GASPROD) AS TotalGas,
       SUM(WATERPROD) AS TotalWater
FROM WellProduction
GROUP BY YEAR
ORDER BY YEAR;
2. Top Producing Well Each Year
sql
SELECT YEAR, WELL_NM, OILPROD
FROM (
    SELECT YEAR, WELL_NM, OILPROD,
           RANK() OVER (PARTITION BY YEAR ORDER BY OILPROD DESC) AS OilRank
    FROM WellProduction
) Ranked
WHERE OilRank = 1;
3. Company Production Ranking
sql
SELECT CoName,
       SUM(OILPROD) AS TotalOil,
       RANK() OVER (ORDER BY SUM(OILPROD) DESC) AS CompanyRank
FROM WellProduction
GROUP BY CoName;
4. Gas-to-Oil Ratio
sql
SELECT WELL_NM, YEAR,
       SUM(GASPROD) * 1.0 / NULLIF(SUM(OILPROD),0) AS GasOilRatio
FROM WellProduction
GROUP BY WELL_NM, YEAR;

# 📸 Excel Dashboard Features
Line chart: Oil production trend by month

Combo chart: Oil vs Gas comparison

Bar chart: Top 10 company, country in oil,gas, water production

Pie charts: side track, top 3 well status

Slicers: Filter by year, company, county


# 🏆 Use Cases
Energy industry analytics

Academic research on production trends

Business intelligence reporting

Portfolio showcase for SQL + Excel skills

🤝 Contributing
Pull requests are welcome. For major changes, open an issue first to discuss improvements.

📬 Contact
Created by Olatunji Titilayo

LinkedIn: https://www.linkedin.com/in/titilayo-olatunji-82445120a/

GitHub: @Titilayo19
