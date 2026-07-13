# Healthcare Operations Intelligence Platform

An end-to-end healthcare analytics project that takes raw synthetic patient data, loads it into a validated PostgreSQL data warehouse, and surfaces it through a 6-page executive Power BI dashboard — built to help hospital leadership answer operational, clinical, and financial questions from a single source of truth.

**Author:** Himnish Kumar

## Overview

Hospitals generate large volumes of clinical and operational data every day, but it's typically scattered across disconnected systems, making even basic operational questions hard to answer. This project builds a relational healthcare database and analytics layer on top of the **Synthea synthetic healthcare dataset**, covering patients, encounters, providers, organizations, payers, conditions, procedures, medications, careplans, and observations.

The pipeline runs the full path from raw data to decision-ready dashboards:

```
Raw CSV Files (Synthea)
        │
        ▼
Python ETL (extract → transform → validate)
        │
        ▼
PostgreSQL (healthcare schema, 10 raw tables)
        │
        ▼
SQL Analytics Layer (business-friendly views)
        │
        ▼
Power BI Dashboard (6 pages)
```

## Business Problem

Hospital administrators need fast, reliable answers to questions like:

- Are patient admissions and revenue increasing?
- Which providers and organizations carry the largest workload?
- Which encounter types and conditions consume the most resources?
- How much does patient care actually cost, and how much is insurance actually covering?
- Who are our patients, demographically, and how does that affect cost?

This project centralizes the data needed to answer those questions in one place, and packages the answers into a dashboard non-technical stakeholders can use directly.

## Data Source

[Synthea](https://synthea.mitre.org/) — an open-source synthetic patient generator that produces realistic (but not real) healthcare data. No real patient information is used anywhere in this project.

| Table | Rows Loaded |
|---|---:|
| patients | 1,163 |
| organizations | 1,127 |
| providers | 5,056 |
| payers | 10 |
| encounters | 61,459 |
| conditions | 38,094 |
| procedures | 83,823 |
| medications | 56,430 |
| observations | 531,144 |
| careplans | 3,931 |
| **Total** | **782,237** |

## Repository Structure

```
Data_Analysis/
│
├── dataset/
│   └── raw/                    Raw Synthea CSV extracts + data profiling notebook
│
├── database/                   PostgreSQL DDL, run in order
│   ├── 01_create_schema.sql
│   ├── 02_create_tables.sql
│   ├── 03_constraints.sql
│   └── 04_indexes.sql
│
├── etl/                        Python ETL pipeline
│   ├── load_synthea.py         Main orchestrator (read → transform → validate → load)
│   ├── config.py                DB connection + raw data folder path
│   ├── database.py              SQLAlchemy engine + connection test
│   ├── transformers.py          Data cleaning / type transforms
│   ├── validators.py            Column, PK, UUID, date, and value validation
│   ├── loader.py                Reusable PostgreSQL bulk loader
│   ├── logger.py                Central logging config
│   ├── metrics.py                ETL run metrics + summary report
│   ├── requirements.txt
│   ├── views/                    Business-friendly SQL views (one per subject area)
│   └── validation/               Standalone data-quality SQL checks
│
├── logs/                        Timestamped ETL run logs
│
├── docs/
│   ├── README.md                 Original business-understanding / project charter doc
│   ├── Data_Dictionary.pdf
│   └── ER_Diagram.png
│
├── Images/                       Dashboard page exports (PNG)
│
├── Healthcare Operations Intelligence Platform.pbix   Power BI source file
└── Healthcare Operations Intelligence Platform.pdf    Static dashboard export
```

## Tech Stack

- **Database:** PostgreSQL (dedicated `healthcare` schema)
- **ETL:** Python (pandas, SQLAlchemy, psycopg2, tqdm)
- **Analytics:** SQL views for business-friendly reporting
- **Visualization:** Power BI
- **Dataset:** Synthea synthetic healthcare data (CSV)

## Database Design

The `database/` scripts build the warehouse in four ordered steps:

1. **`01_create_schema.sql`** — creates the dedicated `healthcare` schema
2. **`02_create_tables.sql`** — creates the 10 raw tables, preserving original Synthea column names
3. **`03_constraints.sql`** — adds primary keys, foreign keys, `NOT NULL`, and `CHECK` constraints
4. **`04_indexes.sql`** — adds indexes on foreign keys and commonly filtered columns

See `docs/ER_Diagram.png` for the full entity-relationship diagram and `docs/Data_Dictionary.pdf` for column-level definitions.

## ETL Pipeline

`etl/load_synthea.py` is the orchestrator. For each table in `LOAD_ORDER` it:

1. Reads the raw CSV from `RAW_DATA_FOLDER` (set in `config.py`)
2. Transforms it (`transformers.py`)
3. Validates it — required columns, duplicate/NULL primary keys, UUID format, dates, negative values (`validators.py`)
4. Loads it into PostgreSQL in chunks of 5,000 rows (`loader.py`)
5. Records timing, row counts, and pass/fail status (`metrics.py`), and writes a run log to `logs/`

### Running the pipeline

```bash
cd etl
pip install -r requirements.txt
```

Update `config.py` with your PostgreSQL credentials and the local path to the Synthea CSVs, then:

```bash
python load_synthea.py
```

Every run produces a timestamped log in `logs/` and ends with a summary table of rows loaded, load time, and status per table (see `logs/` for a sample run showing all 10 tables loading successfully — 782,237 rows in ~2 minutes).

### Standalone data-quality checks (`etl/validation/`)

Independent SQL scripts for auditing the loaded warehouse directly:

- `Row Count Validation.sql` — confirms loaded row counts match source
- `NULL Primary Keys.sql` / `Duplicate Primary Keys.sql` — key integrity
- `Foreign Key Integrity.sql` — referential integrity across tables
- `Data Profiling.sql` — column-level profiling
- `Business Rules.sql` — domain-specific sanity checks

## Analytics Layer (`etl/views/`)

Business-friendly SQL views sit on top of the raw tables so Power BI (and analysts) never query raw Synthea column names directly:

| View | Purpose |
|---|---|
| `vw_patient_demographics` | Age, gender, and demographic breakdowns |
| `vw_encounter_summary` | Encounter-level detail joined to patient name |
| `vw_provider_performance` | Encounter volume and revenue by provider/specialty/org |
| `vw_condition_summary` | Condition frequency |
| `vw_medication_summary` | Prescription volume, average and total cost |
| `vw_observation_summary` | Observation counts and averaged numeric values |

## Power BI Dashboard

`Healthcare Operations Intelligence Platform.pbix` (static export also included as `.pdf`) is a 6-page interactive report, filterable by year, organization, and encounter type. Page exports are in `Images/`.

| Page | Focus | Sample Metrics |
|---|---|---|
| **Executive Overview** | Top-line KPIs and trends | 1,163 patients · 15,634 ambulatory encounters · ₹108.5M revenue · ₹6.94K avg claim cost · 22.4% insurance coverage · 5,056 active providers |
| **Hospital Operations** | Utilization and volume | 44,543 encounters · 24.4% insured share |
| **Provider Performance** | Workload and revenue concentration | ₹45.8K avg revenue/provider; revenue concentrated among a few top providers |
| **Clinical Analytics** | Condition and treatment patterns | 531K observations · 204 unique conditions |
| **Patient Demographics** | Population profile | Average age 49.1 yrs · 62% female patients |
| **Key Insights** | Narrative summary tying all pages together | Ambulatory-driven, aging, majority-female patient base with heavy self-pay exposure |

**Headline findings:**
- Revenue climbed steadily over ~19 years, spiking sharply in 2015 before settling near ₹2–3M/year.
- Insurance covers only ~22–23% of total cost, leaving substantial out-of-pocket exposure.
- Revenue is concentrated among a small number of standout providers and organizations.
- Stress and social isolation rank among the most frequently recorded conditions — as common as chronic disease.
- The patient base skews older (avg. 49 yrs) and female (62%), with healthcare expense climbing sharply past age 45.

## Key Business Questions Answered

- How many unique patients, encounters, and providers are in the system, and how is that trending over time?
- Which organizations and providers have the highest utilization and revenue?
- Which conditions, procedures, medications, and observations are most common?
- What's the average cost per encounter/claim, and what share does insurance actually cover?
- What does the patient population look like demographically, and how does that relate to cost and condition prevalence?

## Scope

**In scope:** patient demographics, encounters, providers, organizations, payers, conditions, procedures, medications, observations, careplans.

**Out of scope:** imaging, medical devices, supplies, allergies, immunizations, predictive ML, clinical diagnosis.

## Assumptions & Limitations

This project uses **synthetic data only** — no real patient information is included. Staffing, scheduling, lab/imaging workflows, and bed occupancy are either simulated or not represented. Results are intended to demonstrate analytical methodology and pipeline engineering, not real-world hospital performance.

## Future Enhancements

- Readmission and patient outcome analytics
- Time-series revenue/volume forecasting
- Bed occupancy and resource optimization analytics
- Interactive web dashboard as an alternative to Power BI

## Additional Documentation

- `docs/README.md` — original business-understanding charter (objectives, stakeholders, roadmap) written at project kickoff
- `docs/Data_Dictionary.pdf` — column-level data dictionary
- `docs/ER_Diagram.png` — entity-relationship diagram
