# 📊 Data Analytics Portfolio

Welcome to my **Data Analytics & Business Intelligence Portfolio**.

This repository contains practical data analytics projects developed to demonstrate my skills in **Python, Pandas, SQL, Power BI, DAX, data cleaning, data visualization, KPI development, and business analysis**.

The projects follow an end-to-end analytics workflow:

```text
Raw Data
   ↓
Data Cleaning
   ↓
Data Transformation
   ↓
Exploratory Data Analysis
   ↓
SQL Analysis
   ↓
KPI Development
   ↓
Power BI Dashboard
   ↓
Business Insights
   ↓
Recommendations
```

---

# 👩‍💻 About Me

I am a **BA (Hons) ICT student at South Eastern University of Sri Lanka**, building practical skills in data analytics and business intelligence.

I am currently developing my skills for **Data Analyst / BI Analyst internship opportunities**.

### Areas of Interest

* Data Analytics
* Business Intelligence
* SQL
* Python
* Power BI
* Data Visualization
* Business Analysis
* Data Engineering

---

# 🛠️ Technical Skills

### Programming & Data Analysis

* Python
* Pandas
* NumPy
* Jupyter Notebook

### Databases & SQL

* SQL
* PostgreSQL
* Data querying
* Joins
* Aggregations
* Subqueries
* CTEs
* Window functions
* Business analysis queries

### Business Intelligence

* Microsoft Power BI
* DAX
* Data modeling
* KPI development
* Interactive dashboards
* Slicers and filters
* Time-series analysis

### Tools

* Git
* GitHub
* VS Code
* Jupyter Notebook

---

# 📁 Projects

## 1. 🛍️ Customer Behavior Analysis

### Overview

An end-to-end customer analytics project focused on understanding customer purchasing behavior, spending patterns, customer segments, and product/category preferences.

### Tools

```text
Python
Pandas
SQL
Power BI
DAX
Jupyter Notebook
```

### Workflow

```text
Customer Dataset
      ↓
Python/Pandas Data Cleaning
      ↓
Exploratory Data Analysis
      ↓
SQL Analysis
      ↓
KPI Calculation
      ↓
Power BI Dashboard
      ↓
Customer Insights
      ↓
Business Recommendations
```

### Key Analysis

* Customer purchasing behavior
* Customer spending
* Purchase frequency
* Customer segmentation
* Product/category preferences
* High-value customers
* Customer KPIs

### Key KPIs

* Total Customers
* Total Orders
* Total Sales/Revenue
* Average Order Value
* Average Customer Spending
* Purchase Frequency

### Skills Demonstrated

* Data cleaning with Pandas
* Exploratory data analysis
* SQL querying
* Customer analysis
* KPI development
* Power BI dashboard development
* Business insight generation

---

# 2. 📊 Sales & Business Analytics

### Overview

An end-to-end sales analytics and business intelligence project designed to analyze sales performance, customer performance, product performance, regional trends, and business KPIs.

This is the **main BI project** in the portfolio.

### Tools

```text
Python
Pandas
SQL
Power BI
DAX
Jupyter Notebook
```

### Workflow

```text
Raw Sales Data
      ↓
Data Cleaning
      ↓
Feature Engineering
      ↓
Exploratory Data Analysis
      ↓
SQL Business Analysis
      ↓
Power BI Data Model
      ↓
DAX Measures
      ↓
Interactive Dashboard
      ↓
Business Insights
```

---

## 📑 Dashboard Structure

The Power BI report contains three pages.

### Page 1 — Executive Dashboard

Provides a high-level overview of business performance.

#### KPIs

* Total Sales
* Total Orders
* Total Customers
* Total Products
* Average Order Value

#### Visualizations

* Monthly Sales Trend
* Sales by Category
* Sales by Region
* Sales by Segment
* Top 10 States

#### Filters

* Year
* Region
* Category
* Segment
* Ship Mode

---

### Page 2 — Sales Performance

Focuses on sales trends and performance.

#### KPIs

* Total Sales
* Total Orders
* Average Order Value
* Average Customer Sales

#### Analysis

* Yearly Sales
* Monthly Sales
* Sales by Category
* Sales by Region
* Sales trends

---

### Page 3 — Customer & Product Analysis

Focuses on customer and product performance.

#### KPIs

* Total Customers
* Total Orders
* Average Customer Sales
* Average Order Value

#### Analysis

* Top 10 Customers
* Customer Segment Sales
* Product Performance
* Category Performance

---

## 📅 Data Modeling

A dedicated Date Table is used for time-based analysis.

```text
DateTable
    │
    │ 1 : *
    ↓
Sales_Data
```

Relationship:

```text
DateTable[Date]
       ↓
Sales_Data[Order Date]
```

The model uses a one-to-many relationship with single-direction filtering.

---

## 🧮 Example DAX Measures

### Total Sales

```DAX
Total Sales =
SUM(Sales_Data[Sales])
```

### Total Orders

```DAX
Total Orders =
DISTINCTCOUNT(Sales_Data[Order ID])
```

### Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(Sales_Data[Customer ID])
```

### Total Products

```DAX
Total Products =
DISTINCTCOUNT(Sales_Data[Product ID])
```

### Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)
```

---

## 🔎 Business Questions

The project answers questions such as:

* What is the overall sales performance?
* How do sales change over time?
* Which categories generate the highest sales?
* Which regions perform best?
* Which customer segments generate the most sales?
* Who are the top customers?
* Which states generate the highest sales?
* What is the average order value?
* How do different shipping modes perform?

---

# 3. 🎓 Internship Recruitment Funnel Analysis

### Overview

A SQL and Power BI project designed to analyze the internship recruitment process from candidate application through assessment, interview, and final offer.

### Recruitment Process

```text
Candidate
    ↓
Application
    ↓
Assessment
    ↓
Interview
    ↓
Offer
```

### Tools

```text
SQL
PostgreSQL
Power BI
DAX
```

---

## 🎯 Project Objectives

* Analyze candidate volume
* Analyze recruitment stages
* Calculate conversion rates
* Identify funnel drop-offs
* Analyze department performance
* Analyze assessment outcomes
* Analyze interview outcomes
* Analyze offer conversion
* Create recruitment KPIs
* Build a recruitment dashboard

---

## 🗄️ Data Model

The project contains entities such as:

```text
Candidates
    │
    ↓
Applications
    │
    ├────────→ Departments
    │
    ↓
Assessments
    ↓
Interviews
    ↓
Offers
```

---

## 📊 Recruitment KPIs

The dashboard analyzes:

* Total Candidates
* Total Applications
* Assessment Candidates
* Interview Candidates
* Total Offers
* Application Conversion Rate
* Assessment Conversion Rate
* Interview Conversion Rate
* Offer Rate
* Department-wise Applications

---

## 🔍 Business Questions

### Recruitment Funnel

* How many candidates enter the recruitment process?
* How many candidates reach each stage?
* How many candidates receive offers?
* Where do the largest candidate drop-offs occur?

### Department Analysis

* Which departments receive the most applications?
* How do departments differ in candidate progression?
* Which departments have different assessment/interview outcomes?

### Process Analysis

* What is the conversion rate between stages?
* Which recruitment stage should be investigated further?
* How can recruitment teams monitor the funnel?

---

# 📊 Overall Project Comparison

| Project                     | Main Focus            | Main Tools                    |
| --------------------------- | --------------------- | ----------------------------- |
| Customer Behavior Analysis  | Customer analytics    | Python, Pandas, SQL, Power BI |
| Sales & Business Analytics  | Sales & BI            | Python, Pandas, SQL, Power BI |
| Recruitment Funnel Analysis | Recruitment analytics | SQL, PostgreSQL, Power BI     |

---

# 🔄 Skills Demonstrated Across Projects

## 🐍 Python & Pandas

Across the projects, Python is used for:

* Data loading
* Data inspection
* Missing-value analysis
* Duplicate detection
* Data cleaning
* Data transformation
* Feature engineering
* Exploratory data analysis
* Date/time analysis

---

## 🗄️ SQL

SQL is used to perform:

* Data filtering
* Aggregations
* GROUP BY analysis
* JOIN operations
* CASE statements
* Subqueries
* CTEs
* Window functions
* Ranking
* KPI calculations
* Business analysis

---

## 📊 Power BI

Power BI is used for:

* Data modeling
* Date tables
* Relationships
* DAX measures
* KPI cards
* Charts
* Tables
* Slicers
* Interactive dashboards
* Business reporting

---

## 📈 Business Intelligence

The projects demonstrate the ability to:

* Translate business questions into analytical questions
* Define meaningful KPIs
* Analyze trends
* Identify patterns
* Compare business segments
* Identify potential bottlenecks
* Communicate findings visually
* Generate data-driven recommendations

---

# 📂 Repository Structure

```text
Data-Analytics-Portfolio/
│
├── Customer_Behavior_Analysis/
│   ├── data/
│   ├── notebooks/
│   ├── sql/
│   ├── powerbi/
│   └── README.md
│
├── Sales_Business_Analytics/
│   ├── data/
│   ├── notebooks/
│   ├── sql/
│   ├── powerbi/
│   ├── dashboard/
│   └── README.md
│
├── Internship_Recruitment_Funnel_Analysis/
│   ├── data/
│   ├── sql/
│   ├── powerbi/
│   ├── dashboard/
│   └── README.md
│
├── README.md
└── .gitignore
```

---

# 🚀 Future Projects

Planned projects for expanding the portfolio include:

* Netflix Data Analysis
* Customer Shopping Analysis
* Sales Time-Series Analysis
* Statistical Analysis
* Student Success & Early Warning Analytics
* Excel Data Analysis Project
* Advanced SQL Analytics Project

---

# 📚 Currently Learning

```text
Python
    ↓
Advanced Pandas
    ↓
SQL
    ↓
Statistics
    ↓
Power BI & DAX
    ↓
Excel
    ↓
Business Analysis
    ↓
Advanced Analytics
```

---

# 🎯 Career Goal

I am preparing for internship opportunities in:

* Data Analyst
* BI Analyst
* Business Analyst
* Data/BI-related internship roles

My goal is to continuously improve my ability to transform raw data into **clear insights that can support business decision-making**.

---

# 👩‍💻 Author

**Fathima Shahida**

BA (Hons) ICT
South Eastern University of Sri Lanka

### Technical Focus

```text
Python | Pandas | SQL | PostgreSQL | Power BI | DAX | Excel | Git
```

---

⭐ **Thank you for visiting my Data Analytics Portfolio!**

If you are interested in my projects, feel free to explore the individual project folders and dashboards.
