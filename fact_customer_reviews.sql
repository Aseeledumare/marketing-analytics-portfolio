-- Query to clean whitespace issues in the ReviewText column

SELECT 
    ReviewID,  -- Selects the unique identifier for each review
    CustomerID,  -- Selects the unique identifier for each customer
    ProductID,  -- Selects the unique identifier for each product
    ReviewDate,  -- Selects the date when the review was written
    Rating,  -- Selects the numerical rating given by the customer (e.g., 1 to 5 stars)
    -- Cleans up the ReviewText by replacing double spaces with single spaces to ensure the text is more readable and standardized
    LTRIM(RTRIM(
    REPLACE(REPLACE(REPLACE(ReviewText, ' ', '<>'), '><', ''), '<>', ' ')
)) AS ReviewText
FROM 
    dbo.customer_reviews;  -- Specifies the source table from which to select the data


SELECT 
    ReviewText,
    COUNT(*) AS Frequency,
    ROUND(AVG(CAST(Rating AS FLOAT)), 2) AS AvgRating
FROM (
SELECT 
    ReviewID,  -- Selects the unique identifier for each review
    CustomerID,  -- Selects the unique identifier for each customer
    ProductID,  -- Selects the unique identifier for each product
    ReviewDate,  -- Selects the date when the review was written
    Rating,  -- Selects the numerical rating given by the customer (e.g., 1 to 5 stars)
    -- Cleans up the ReviewText by replacing double spaces with single spaces to ensure the text is more readable and standardized
    LTRIM(RTRIM(
    REPLACE(REPLACE(REPLACE(ReviewText, ' ', '<>'), '><', ''), '<>', ' ')
)) AS ReviewText
FROM 
    dbo.customer_reviews  -- Specifies the source table from which to select the data
    ) AS cleaned
GROUP BY ReviewText
ORDER BY Frequency DESC;

