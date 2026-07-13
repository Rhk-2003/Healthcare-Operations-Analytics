"""
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform

File    : loader.py

Description:
Reusable PostgreSQL data loader.
===============================================================================
"""

import pandas as pd
from sqlalchemy import text

from database import engine
from logger import logger


def truncate_table(table_name: str):

    logger.info(f"Truncating table: {table_name}")

    with engine.begin() as conn:

        conn.execute(
            text(
                f"TRUNCATE TABLE healthcare.{table_name} CASCADE;"
            )
        )


def load_dataframe(
    df: pd.DataFrame,
    table_name: str,
    mode: str = "replace"
):

    if mode not in ["replace", "append"]:
        raise ValueError("mode must be 'replace' or 'append'")

    if mode == "replace":
        truncate_table(table_name)

    logger.info(f"Loading {table_name}")

    logger.info(f"Rows: {len(df):,}")

    df.to_sql(
        name=table_name,
        con=engine,
        schema="healthcare",
        if_exists="append",
        index=False,
        method="multi",
        chunksize=5000
    )

    logger.info(f"{table_name} loaded successfully.")