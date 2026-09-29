# 📊 Sales & Business Analytics

An end-to-end Business Intelligence project that transforms raw sales data into actionable business insights using **Python, Pandas, PostgreSQL, SQL, DAX and Power BI**.

---

## 📌 Project Overview

This project analyzes sales, customers, products, regions, customer segments and shipping performance to understand overall business performance and identify important trends.

The project follows a complete analytics workflow:

```text
Raw Data
    ↓
Python / Pandas
    ↓
Data Cleaning & Feature Engineering
    ↓
PostgreSQL
    ↓
SQL Business Analysis
    ↓
Data Modeling
    ↓
DAX Measures
    ↓
Power BI
    ↓
Interactive Dashboard
    ↓
Business Insights
    ↓
Business Recommendations
```

The project was designed as an internship-level Business Intelligence portfolio project demonstrating the complete journey from raw data to business decision support.

---

# 🎯 Business Objective

The main objective is to analyze sales performance and answer important business questions such as:

* What is the overall sales performance?
* How are sales changing over time?
* Which categories generate the most sales?
* Which sub-categories perform best?
* Which regions and states contribute the most sales?
* Which customer segments generate the most revenue?
* Who are the top customers?
* Which products generate the highest sales?
* How does shipping performance vary?
* What business insights can be identified from the data?

---

# 🛠️ Tools & Technologies

| Tool       | Purpose                                      |
| ---------- | -------------------------------------------- |
| Python     | Data cleaning and preprocessing              |
| Pandas     | Data manipulation and feature engineering    |
| PostgreSQL | Database storage                             |
| SQL        | Business analysis                            |
| Power BI   | Data visualization and dashboard development |
| DAX        | KPI and analytical calculations              |
| Git        | Version control                              |
| GitHub     | Project documentation and portfolio          |

---

# 📂 Project Structure

```text
Sales-Business-Analytics/
│
├── data/
│   ├── raw/
│   │   └── superstore.csv
│   │
│   └── cleaned/
│       └── superstore_cleaned.csv
│
├── python/
│   └── sales_cleaning_analysis.ipynb
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_quality.sql
│   ├── 03_business_analysis.sql
│   └── 04_advanced_analysis.sql
│
├── powerbi/
│   └── Sales_Business_Analytics.pbix
│
├── screenshots/
│   ├── executive_dashboard.png
│   ├── sales_performance.png
│   ├── customer_product_analysis.png
│   └── customer_details.png
│
├── README.md
└── requirements.txt
```

---

# 📊 Dataset

The project uses a Superstore sales dataset containing transactional sales information.

## Main Columns

| Column        | Description                |
| ------------- | -------------------------- |
| Row ID        | Unique row identifier      |
| Order ID      | Order identifier           |
| Order Date    | Date the order was placed  |
| Ship Date     | Date the order was shipped |
| Ship Mode     | Shipping method            |
| Customer ID   | Customer identifier        |
| Customer Name | Customer name              |
| Segment       | Customer segment           |
| Country       | Country                    |
| City          | City                       |
| State         | State                      |
| Postal Code   | Postal code                |
| Region        | Geographic region          |
| Product ID    | Product identifier         |
| Category      | Product category           |
| Sub-Category  | Product sub-category       |
| Product Name  | Product name               |
| Sales         | Sales amount               |

Additional analytical columns were created during preprocessing:

```text
Shipping_Days
Year
Month
Month_Name
Quarter
Year_Month
```

---

# 🐍 Python / Pandas

Python was used as the first stage of the data pipeline.

## Data Cleaning

The following activities were performed:

* Loaded the raw CSV dataset
* Inspected dataset dimensions
* Checked data types
* Checked missing values
* Checked duplicate records
* Converted date columns
* Standardized categorical fields
* Validated sales values
* Created shipping duration
* Created time-based analytical columns
* Exported the cleaned dataset

### Example

```python
df["Order Date"] = pd.to_datetime(df["Order Date"])

df["Ship Date"] = pd.to_datetime(df["Ship Date"])

df["Shipping_Days"] = (
    df["Ship Date"] - df["Order Date"]
).dt.days
```

Time-based features were also created:

```python
df["Year"] = df["Order Date"].dt.year

df["Month"] = df["Order Date"].dt.month

df["Month_Name"] = df["Order Date"].dt.strftime("%B")

df["Quarter"] = df["Order Date"].dt.quarter

df["Year_Month"] = (
    df["Order Date"]
    .dt.to_period("M")
    .astype(str)
)
```

---

# 🗄️ PostgreSQL & SQL

The cleaned dataset was loaded into PostgreSQL for structured business analysis.

## SQL Files

### `01_database_setup.sql`

Responsible for:

* Creating the sales table
* Defining column data types
* Import validation
* Creating indexes
* Checking the date range

### `02_data_quality.sql`

Responsible for:

* Row-count validation
* Duplicate checks
* NULL checks
* Invalid sales checks
* Date validation
* Shipping-day validation
* Category validation
* Region validation
* Segment validation

### `03_business_analysis.sql`

Contains core business analysis including:

* Total sales
* Total orders
* Total customers
* Total products
* Average order value
* Average customer sales
* Sales by category
* Sales by sub-category
* Sales by region
* Sales by state
* Sales by segment
* Sales by shipping mode
* Monthly sales
* Quarterly sales
* Yearly sales
* Top customers
* Top products
* Regional/category analysis
* Sales contribution analysis

### `04_advanced_analysis.sql`

Contains advanced SQL techniques including:

* CTEs
* Window functions
* Ranking
* `ROW_NUMBER()`
* `RANK()`
* `LAG()`
* Running totals
* Month-over-month growth
* Year-over-year growth
* Customer contribution
* Product ranking within categories
* Regional rankings
* SQL views

---

# 📈 Power BI Data Model

The Power BI model uses:

```text
DateTable
    |
    | 1 : *
    |
Sales_Data
```

The main relationship is:

```text
DateTable[Date]
       ↓
Sales_Data[Order Date]
```

The date table was created to support time-based analysis and DAX time-intelligence calculations.

---

# 🧮 DAX Measures

The following measures were created.

## Total Sales

```DAX
Total Sales =
SUM(Sales_Data[Sales])
```

## Total Orders

```DAX
Total Orders =
DISTINCTCOUNT(Sales_Data[Order ID])
```

## Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(Sales_Data[Customer ID])
```

## Total Products

```DAX
Total Products =
DISTINCTCOUNT(Sales_Data[Product ID])
```

## Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)
```

## Average Customer Sales

```DAX
Average Customer Sales =
DIVIDE(
    [Total Sales],
    [Total Customers]
)
```

## Previous Year Sales

```DAX
Previous Year Sales =
CALCULATE(
    [Total Sales],
    SAMEPERIODLASTYEAR(DateTable[Date])
)
```

## Sales Growth %

```DAX
Sales Growth % =
DIVIDE(
    [Total Sales] - [Previous Year Sales],
    [Previous Year Sales]
)
```

## YTD Sales

```DAX
YTD Sales =
TOTALYTD(
    [Total Sales],
    DateTable[Date]
)
```

---

# 📊 Power BI Dashboard

The Power BI report contains three main analytical pages.

---

## Page 1 — Executive Dashboard

### Purpose

Provides a high-level overview of business performance.

### KPIs

* Total Sales
* Total Orders
* Total Customers
* Total Products
* Average Order Value

### Visuals

* Monthly Sales Trend
* Sales by Category
* Sales by Region
* Sales by Customer Segment

### Filters

* Year
* Region
* Category
* Segment
* Ship Mode

---

## Page 2 — Sales Performance

### Purpose

Analyzes sales trends and performance across different dimensions.

### KPIs

* Total Sales
* Total Orders
* Average Order Value
* Average Customer Sales

### Visuals

* Yearly Sales Performance
* Monthly Sales Trend
* Sales Growth
* Sales by State
* Sales by Ship Mode
* Category and Sub-Category Analysis

---

## Page 3 — Customer & Product Analysis

### Purpose

Analyzes customer contribution and product performance.

### KPIs

* Total Customers
* Total Orders
* Average Customer Sales
* Average Order Value

### Visuals

* Top 10 Customers
* Customer Segment Sales
* Top 10 Products
* Category/Sub-Category Matrix

---

# 🔎 Drill-Through Analysis

A dedicated Customer Details page was created using Power BI drill-through functionality.

The page provides customer-level information including:

* Total Sales
* Total Orders
* Average Order Value
* Sales Trend
* Order Details
* Products Purchased
* Categories

Users can right-click a customer from the customer analysis page and navigate to the detailed customer view.

---

# 💡 Tooltip Analysis

A dedicated tooltip page was created to provide additional information when users hover over dashboard visuals.

The tooltip includes:

* Total Sales
* Total Orders
* Average Order Value

This allows additional context to be displayed without overcrowding the main dashboard.

---

# 📌 Key Business Insights

The final insights below should be updated using the actual results from the completed dashboard.

### Insight 1 — Category Performance

[Insert the actual finding about the highest and lowest-performing categories.]

### Insight 2 — Customer Segment

[Insert the actual finding about customer segment contribution.]

### Insight 3 — Regional Performance

[Insert the actual finding about regional or state-level sales.]

### Insight 4 — Customer Concentration

[Insert the actual finding about the contribution of high-value customers.]

### Insight 5 — Sales Trend

[Insert the actual finding about monthly/yearly sales trends.]

---

# 💼 Business Recommendations

Recommendations should be based directly on the findings.

### 1. Category Strategy

Use category-level sales performance to support inventory planning and promotional decisions.

### 2. Customer Retention

Identify high-value customers and develop targeted retention strategies based on their purchasing behavior.

### 3. Geographic Opportunities

Investigate lower-performing regions and states to understand differences in demand and identify opportunities for growth.

### 4. Product Strategy

Use product-level sales performance to support product prioritization and promotional planning.

### 5. Time-Based Planning

Use historical sales trends to support future inventory, marketing and sales planning.

---

# 🔍 Data Validation

The SQL results were compared with Power BI results to ensure consistency.

Key metrics validated include:

```text
Total Sales
Total Orders
Total Customers
Total Products
Category Sales
Regional Sales
Customer Sales
Product Sales
```

This validation helps ensure that calculations remain consistent across the SQL and Power BI layers.

---

# 📸 Dashboard Screenshots

## Executive Dashboard

![Executive Dashboard](screenshots/executive_dashboard.png)

## Sales Performance

![Sales Performance](screenshots/sales_performance.png)

## Customer & Product Analysis

![Customer & Product Analysis](screenshots/customer_product_analysis.png)

## Customer Details

![Customer Details](screenshots/customer_details.png)

---

# 🎓 Skills Demonstrated

This project demonstrates practical skills in:

### Data Analysis

* Data cleaning
* Exploratory data analysis
* Data validation
* Feature engineering
* KPI development

### Python

* Python
* Pandas
* NumPy
* Date manipulation
* Data preprocessing

### SQL

* PostgreSQL
* SELECT
* WHERE
* GROUP BY
* HAVING
* ORDER BY
* DISTINCT
* Aggregate functions
* CTEs
* Window functions
* Ranking
* `LAG()`
* Date functions
* Views
* Data-quality validation

### Power BI

* Data modeling
* Date tables
* Relationships
* DAX
* KPI cards
* Slicers
* Interactive visualizations
* Drill-through
* Tooltips
* Dashboard design
* Business storytelling

### Business Intelligence

* Sales analysis
* Customer analysis
* Product analysis
* Geographic analysis
* Trend analysis
* Business insights
* Data-driven recommendations

---

# 🚀 End-to-End Workflow

```text
                 RAW DATA
                    │
                    ▼
             Python / Pandas
                    │
                    ▼
           Data Cleaning
                    │
                    ▼
        Feature Engineering
                    │
                    ▼
             Cleaned CSV
                    │
                    ▼
              PostgreSQL
                    │
                    ▼
             SQL Analysis
                    │
                    ▼
             Data Modeling
                    │
                    ▼
                 DAX
                    │
                    ▼
               Power BI
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
       Executive   Sales   Customer &
       Dashboard  Analysis Product Analysis
          │         │         │
          └─────────┼─────────┘
                    ▼
            Business Insights
                    │
                    ▼
             Recommendations
```

---

# 📁 Project Deliverables

The completed project contains:

* Cleaned sales dataset
* Python/Pandas analysis notebook
* PostgreSQL database setup
* SQL data-quality queries
* SQL business-analysis queries
* Advanced SQL analysis
* Power BI data model
* DAX measures
* Three-page interactive dashboard
* Customer drill-through page
* Tooltip page
* Business insights
* Business recommendations
* GitHub documentation

---

# 🎯 Portfolio Objective

This project was developed to demonstrate the ability to take a business dataset from raw data through the complete Business Intelligence workflow:

**Data Preparation → SQL → Data Modeling → DAX → Visualization → Business Analysis → Decision Support**

It demonstrates practical skills relevant to entry-level **Business Intelligence, Data Analyst and BI Analyst internships**.

---

# 👩‍💻 Author

**F.Shahida Shajahan**

BA (Hons) ICT Student
South Eastern University of Sri Lanka

---

# ⭐ Project Focus

**Python + SQL + Power BI + Business Intelligence**

> Turning raw business data into meaningful insights and actionable decisions.
