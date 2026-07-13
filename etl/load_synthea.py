"""
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar

File    : load_synthea.py

Description:
Main ETL Orchestrator

Workflow
--------
Read CSV
    ↓
Transform
    ↓
Validate
    ↓
Load into PostgreSQL
    ↓
Collect Metrics
===============================================================================
"""

import os
import time

import pandas as pd
from tqdm import tqdm

from config import RAW_DATA_FOLDER
from logger import logger
from transformers import transform_dataframe
from validators import validate_dataframe
from loader import load_dataframe
from metrics import ETLMetrics


# =============================================================================
# TABLE LOAD ORDER
# =============================================================================
# First run only. Once patients loads successfully,
# uncomment the remaining tables.


LOAD_ORDER = [

    "patients",
    "organizations",
    "providers",
    "payers",

    "encounters",

    "conditions",
    "procedures",
    "medications",
    "observations",
    "careplans"

]

# Full Load Order
# LOAD_ORDER = [
#     "patients",
#     "organizations",
#     "providers",
#     "payers",
#     "encounters",
#     "conditions",
#     "procedures",
#     "medications",
#     "observations",
#     "careplans"
# ]


# =============================================================================
# Banner
# =============================================================================

def print_banner():

    logger.info("=" * 80)
    logger.info("Hospital Operations Analytics ETL Pipeline")
    logger.info("=" * 80)


# =============================================================================
# Process Single Table
# =============================================================================

def process_table(table_name: str, metrics: ETLMetrics):

    start = time.perf_counter()

    try:

        path = os.path.join(
            RAW_DATA_FOLDER,
            f"{table_name}.csv"
        )

        logger.info("")
        logger.info(f"Reading {table_name}.csv")

        df = pd.read_csv(
            path,
            keep_default_na=True,
            na_values=["", "NULL", "null"]
        )

        logger.info(f"Rows Read : {len(df):,}")

        logger.info("Transforming Data...")

        df = transform_dataframe(
            df,
            table_name
        )

        logger.info("Validating Data...")

        validate_dataframe(
            df,
            table_name
        )

        logger.info("Loading into PostgreSQL...")

        load_dataframe(
            df=df,
            table_name=table_name,
            mode="replace"
        )

        duration = time.perf_counter() - start

        metrics.add_success(
            table=table_name,
            rows=len(df),
            duration=duration
        )

        logger.info(
            f"{table_name} completed successfully "
            f"in {duration:.2f} seconds."
        )

    except Exception as e:

        duration = time.perf_counter() - start

        metrics.add_failure(
            table=table_name,
            error=str(e),
            duration=duration
        )

        logger.exception(
            f"Failed while processing table '{table_name}'"
        )


# =============================================================================
# Main
# =============================================================================

def main():

    print_banner()

    metrics = ETLMetrics()

    for table in tqdm(
        LOAD_ORDER,
        desc="Loading Tables"
    ):

        process_table(
            table_name=table,
            metrics=metrics
        )

    metrics.summary()

    logger.info("")
    logger.info("ETL Pipeline Finished Successfully.")


# =============================================================================
# Entry Point
# =============================================================================

if __name__ == "__main__":

    main()