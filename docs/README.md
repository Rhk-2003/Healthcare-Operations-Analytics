# Hospital Operations & Patient Flow Analytics Platform

A healthcare data analytics project that integrates patient, encounter, provider, and financial data into a centralized PostgreSQL database and an executive Power BI dashboard — designed to help hospital leadership make data-driven operational decisions.

## Overview

Hospitals generate large volumes of operational and clinical data every day, but this data is often scattered across disconnected tables, making it hard to answer basic operational questions. This project builds a relational healthcare database and analytics layer on top of the **Synthea synthetic healthcare dataset**, covering patients, encounters, providers, organizations, payers, conditions, procedures, medications, and observations.

The end goal is a full analytics pipeline: raw data → clean relational database → SQL analytics → Python EDA → executive Power BI dashboards.

## Business Problem

Hospital administrators need fast, reliable answers to questions like:

- Are patient admissions increasing?
- Which hospitals have the highest utilization?
- Which providers carry the largest workload?
- Which encounter types consume the most resources?
- Which conditions are most common?
- How much does patient care actually cost?

This project centralizes the data needed to answer those questions in one place.

## Objectives

- Centralize healthcare operational data into a relational database
- Measure hospital operational performance and patient flow
- Analyze provider utilization and workload distribution
- Analyze healthcare costs and payer contribution
- Build executive-ready dashboards with actionable insights

## Analytical Objectives

The analytics platform should enable users to:

- Monitor hospital utilization
- Evaluate provider workload
- Understand patient demographics
- Analyze healthcare costs
- Identify high-volume clinical conditions

## Scope

**In scope:** patient demographics, encounters, providers, organizations, payers, conditions, procedures, medications, observations, care plans

**Out of scope:** imaging, medical devices, supplies, allergies, immunizations, predictive ML, clinical diagnosis

## Data Source

[Synthea](https://synthea.mitre.org/) — an open-source synthetic patient generator producing realistic (but not real) healthcare data.

**Core tables:** Patients, Organizations, Providers, Payers, Encounters, Conditions, Procedures, Medications, Observations, Careplans

## Key Business Questions

| Category | Example Questions |
|---|---|
| Patient Analytics | Unique patients treated, age/gender distribution, top patient origin cities |
| Encounter Analytics | Encounter volume, most common encounter class, average duration, trends over time |
| Provider Analytics | Highest-volume providers, top specialties, workload balance |
| Organization Analytics | Utilization, patient volume, and revenue by facility |
| Clinical Analytics | Most common conditions, procedures, medications, observations |
| Financial Analytics | Average encounter/procedure cost, insurance coverage, payer contribution |

## KPIs Tracked

**Executive:** Total Patients, Total Encounters, Total Providers, Total Organizations, Avg Encounter Cost, Avg Encounter Duration, Avg Healthcare Expenses, Avg Insurance Coverage

**Operational:** Patients per Provider, Encounters per Organization, Provider/Organization Utilization

**Clinical:** Top Conditions, Procedures, Medications, Encounter Types

**Financial:** Total Claims, Avg Claim Cost, Insurance Coverage %, Revenue by Organization

## Tech Stack

- **Database:** PostgreSQL
- **Analytics:** SQL, Python (EDA & statistical analysis)
- **Visualization:** Power BI
- **Dataset:** Synthea synthetic healthcare data

## Project Roadmap

1. **Business Understanding** — BRD, ER diagram, data dictionary
2. **Database Design** — schema, tables, constraints, indexes
3. **Data Loading** — import, validate, and clean CSV data
4. **SQL Analytics** — views, business queries, performance tuning
5. **Python Analytics** — EDA, statistics, feature engineering
6. **Power BI Dashboards** — Executive, Operations, Clinical, Financial views
7. **Business Recommendations** — final report and documentation

## Project Architecture

Raw CSV Files
        │
        ▼
PostgreSQL Database
        │
        ▼
Data Cleaning & Validation
        │
        ▼
SQL Analytics Layer
        │
        ▼
Python (EDA & Statistics)
        │
        ▼
Power BI Dashboards
        │
        ▼
Business Recommendations

## Repository Structure

```text
Hospital-Operations-Analytics/
│
├── data/
├── database/
├── notebooks/
├── powerbi/
├── docs/
├── reports/
└── README.md
```

## Deliverables

- PostgreSQL database with relational schema
- ER diagram and data dictionary
- SQL scripts and validation report
- Exploratory & statistical analysis notebooks
- Power BI dashboard
- Executive business report

## Stakeholders

Primary Stakeholders

- Hospital CEO
- Hospital Operations Manager
- Chief Medical Officer
- Clinical Directors
- Healthcare Data Analysts

Secondary Stakeholders

- Finance Department
- Insurance Partners
- Quality Improvement Team

## Success Criteria

The project will be considered successful if it:

- Produces a validated relational PostgreSQL database
- Provides accurate operational KPIs
- Enables interactive Power BI dashboards
- Supports SQL-based business analysis
- Generates actionable business insights

## Future Enhancements

- Readmission analysis
- Patient outcome analytics
- Time-series forecasting
- Bed occupancy analytics
- Hospital resource optimization
- Interactive web dashboard

## Assumptions & Limitations

This project uses **synthetic data only** — no real patient information is included. Costs, staffing, scheduling, lab/imaging workflows, and bed occupancy are either simulated or not represented. Results are intended to demonstrate analytical methodology, not real-world hospital performance.

## Author

Himnish Kumar
