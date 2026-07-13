"""
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
File    : transformers.py

Description:
Contains reusable data transformation functions for the Synthea ETL pipeline.
===============================================================================
"""

import pandas as pd


# =============================================================================
# Date Columns
# =============================================================================

DATE_COLUMNS = {
    "patients": [
        "BIRTHDATE",
        "DEATHDATE"
    ],

    "conditions": [
        "START",
        "STOP"
    ],

    "medications": [
        "START",
        "STOP"
    ],

    "careplans": [
        "START",
        "STOP"
    ]
}


# =============================================================================
# Timestamp Columns
# =============================================================================

TIMESTAMP_COLUMNS = {
    "encounters": [
        "START",
        "STOP"
    ],

    "procedures": [
        "START",
        "STOP"
    ],

    "observations": [
        "DATE"
    ]
}


# =============================================================================
# Parse Dates
# =============================================================================

def parse_dates(df: pd.DataFrame, table_name: str) -> pd.DataFrame:

    if table_name in DATE_COLUMNS:

        for column in DATE_COLUMNS[table_name]:

            if column in df.columns:

                df[column] = pd.to_datetime(
    			df[column],
    			format="ISO8601",
    			errors="coerce"
		).dt.date

    return df


# =============================================================================
# Parse Timestamps
# =============================================================================

def parse_timestamps(df: pd.DataFrame, table_name: str) -> pd.DataFrame:

    if table_name in TIMESTAMP_COLUMNS:

        for column in TIMESTAMP_COLUMNS[table_name]:

            if column in df.columns:

                df[column] = pd.to_datetime(
                    df[column],
                    utc=True,
                    errors="coerce"
                )

    return df


# =============================================================================
# Replace Empty Strings with NULL
# =============================================================================

def replace_empty_with_null(df: pd.DataFrame) -> pd.DataFrame:

    return df.replace("", pd.NA)


def normalize_strings(df: pd.DataFrame) -> pd.DataFrame:
    """
    Remove leading/trailing whitespace from string columns.
    """

    object_columns = df.select_dtypes(include=["object"]).columns

    for column in object_columns:

        df[column] = (
            df[column]
            .astype("string")
            .str.strip()
        )

    return df

# =============================================================================
# Main Transformation Pipeline
# =============================================================================

def transform_dataframe(df: pd.DataFrame,
                        table_name: str) -> pd.DataFrame:

    df = replace_empty_with_null(df)

    df = normalize_strings(df)

    df = parse_dates(df, table_name)

    df = parse_timestamps(df, table_name)

    return df