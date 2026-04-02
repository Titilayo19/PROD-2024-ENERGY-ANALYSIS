SELECT *
FROM Prod2024

-- select gasprod,waterprod,oilprod
SELECT GasProd, WaterProd, OilProd
FROM Prod2024

-- SUM OF GASPROD, WATERPROD, OILPROD GROUP BY YEAR
SELECT 
    Year,
    SUM(GasProd) AS TotalGasProd,
    SUM(WaterProd) AS TotalWaterProd,
    SUM(OilProd) AS TotalOilProd
FROM Prod2024
GROUP BY Year;

--WHICH COMPANY PRODUCE THE MOST
SELECT CoName, SUM(GASPROD+OILPROD+WATERPROD) AS TotalProd
FROM Prod2024
GROUP BY CoName
ORDER BY TotalProd DESC;

--total production grouped by well type
SELECT 
    Well_Typ,
    SUM(GasProd) AS TotalGasProd,
    SUM(WaterProd) AS TotalWaterProd,
    SUM(OilProd) AS TotalOilProd
FROM Prod2024
GROUP BY Well_Typ;

-- top 10 apiwellno
SELECT TOP 10 API_WellNo, 
    SUM(GasProd) AS TotalGasProd,
    SUM(WaterProd) AS TotalWaterProd,
    SUM(OilProd) AS TotalOilProd
FROM Prod2024
GROUP BY API_WellNo;

--top 10 API WELL NO USING TOTAL OIL
SELECT TOP 10 API_WellNo, SUM(OILPROD) AS TotalOil
FROM Prod2024
WHERE YEAR = 2024
GROUP BY API_WellNo
ORDER BY TotalOil DESC;

--top 10 API WELL NO USING TOTAL gas prod
SELECT TOP 10 API_WellNo, SUM(GasProd) AS Totalgas
FROM Prod2024
WHERE YEAR = 2024
GROUP BY API_WellNo
ORDER BY Totalgas DESC;

--top 10 API WELL NO USING TOTAL water prod
SELECT TOP 10 API_WellNo, SUM(WaterProd) AS Totalwater
FROM Prod2024
WHERE YEAR = 2024
GROUP BY API_WellNo
ORDER BY Totalwater DESC;

-- country with the highest gas prod, oilprod and waterprod
SELECT COUNTY, SUM(GASPROD) AS TotalGas
FROM Prod2024
WHERE YEAR = 2024
GROUP BY COUNTY
ORDER BY TotalGas DESC;

SELECT COUNTY, SUM(OILPROD) AS TotalOil
FROM Prod2024
WHERE YEAR = 2024
GROUP BY COUNTY
ORDER BY TotalOil DESC;

SELECT COUNTY, SUM(WATERPROD) AS TotalWater
FROM Prod2024
WHERE YEAR = 2024
GROUP BY COUNTY
ORDER BY TotalWater DESC;

-- company name with the highest gasprod, waterprod, oilprod
SELECT CoName, SUM(GASPROD) AS TotalGas
FROM Prod2024
WHERE YEAR = 2024
GROUP BY CoName
ORDER BY TotalGas DESC;

SELECT CoName, SUM(OILPROD) AS TotalOil
FROM Prod2024
WHERE YEAR = 2024
GROUP BY CoName
ORDER BY TotalOil DESC;

SELECT CoName, SUM(WATERPROD) AS TotalWater
FROM Prod2024
WHERE YEAR = 2024
GROUP BY CoName
ORDER BY TotalWater DESC;

-- monthly prod of gasprod, oilprod, waterprod
SELECT MONTHPROD, SUM(GASPROD) AS MonthlyGas
FROM Prod2024
GROUP BY MONTHPROD
ORDER BY MONTHPROD;

SELECT MONTHPROD, SUM(OILPROD) AS MonthlyOil
FROM Prod2024
GROUP BY MONTHPROD
ORDER BY MONTHPROD;

SELECT MONTHPROD, SUM(WATERPROD) AS MonthlyWater
FROM Prod2024
GROUP BY MONTHPROD
ORDER BY MONTHPROD;

--gas to oil ratio per field
SELECT FIELD, SUM(GASPROD)/NULLIF(SUM(OILPROD),0) AS GasOilRatio
FROM Prod2024
GROUP BY FIELD
ORDER BY GasOilRatio DESC;
-- SIDE TRACK VS AVG PRODS
SELECT SideTrck, AVG(GASPROD) AS AvgGas, AVG(OILPROD) AS AvgOil, AVG(WATERPROD) AS AvgWater
FROM Prod2024
GROUP BY SideTrck
ORDER BY SideTrck ASC;

-- sum of prods per town
SELECT TOWN, SUM(GASPROD) AS GasTotal, SUM(OILPROD) AS OilTotal,SUM(WATERPROD) AS WaterTotal
FROM Prod2024
GROUP BY TOWN;

-- completion type vs production performance
SELECT COMPLETION, AVG(GASPROD) AS AvgGas, AVG(OILPROD) AS AvgOil, AVG(WATERPROD) AS AvgWater
FROM Prod2024
GROUP BY COMPLETION;

--top well name ranking 1

SELECT YEAR, WELL_NM, OILPROD
FROM (
    SELECT 
        YEAR,
        WELL_NM,
        OILPROD,
        RANK() OVER (PARTITION BY YEAR ORDER BY OILPROD DESC) AS OilRank
    FROM Prod2024
) Ranked
WHERE OilRank = 1;

SELECT YEAR, WELL_NM, GasProd
FROM (
    SELECT 
        YEAR,
        WELL_NM,
        GasProd,
        RANK() OVER (PARTITION BY YEAR ORDER BY GASPROD DESC) AS GasRank
    FROM Prod2024
) Ranked
WHERE GasRank = 1;

SELECT YEAR, WELL_NM,waterprod 
FROM (
    SELECT 
        YEAR,
        WELL_NM,
        WaterProd,
        RANK() OVER (PARTITION BY YEAR ORDER BY WATERPROD DESC) AS WaterRank
    FROM Prod2024
) Ranked
WHERE WaterRank = 1;

--company ranking
SELECT 
    CoName,
    SUM(OILPROD) AS TotalOil,
    RANK() OVER (ORDER BY SUM(OILPROD) DESC) AS CompanyRank
FROM Prod2024
GROUP BY CoName;

SELECT 
    CoName,
    SUM(GasProd) AS Totalgas,
    RANK() OVER (ORDER BY SUM(GASPROD) DESC) AS CompanyRank
FROM Prod2024
GROUP BY CoName;

SELECT 
    CoName,
    SUM(WaterProd) AS TotalWater,
    RANK() OVER (ORDER BY SUM(waterprod) DESC) AS CompanyRank
FROM Prod2024
GROUP BY CoName;

