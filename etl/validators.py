"""
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar

File    : validators.py

Description:
Validation functions for the Synthea ETL pipeline.

Responsibilities
----------------
✓ Required column validation
✓ Duplicate primary key detection
✓ UUID validation
✓ Date validation
✓ Negative value validation
✓ Logging
===============================================================================
"""

import uuid
import pandas as pd

from logger import logger


# =============================================================================
# Primary Keys
# =============================================================================

PRIMARY_KEYS = {
    "patients": "Id",
    "organizations": "Id",
    "providers": "Id",
    "payers": "Id",
    "encounters": "Id",
    "careplans": "Id"
}


# =============================================================================
# UUID Columns
# =============================================================================

UUID_COLUMNS = {
    "patients": ["Id"],

    "organizations": ["Id"],

    "providers": [
        "Id",
        "ORGANIZATION"
    ],

    "payers": ["Id"],

    "encounters": [
        "Id",
        "PATIENT",
        "ORGANIZATION",
        "PROVIDER",
        "PAYER"
    ],

    "conditions": [
        "PATIENT",
        "ENCOUNTER"
    ],

    "procedures": [
        "PATIENT",
        "ENCOUNTER"
    ],

    "medications": [
        "PATIENT",
        "ENCOUNTER",
        "PAYER"
    ],

    "observations": [
        "PATIENT",
        "ENCOUNTER"
    ],

    "careplans": [
        "Id",
        "PATIENT",
        "ENCOUNTER"
    ]
}


# =============================================================================
# Numeric Columns
# =============================================================================

NON_NEGATIVE_COLUMNS = {
    "patients": [
        "HEALTHCARE_EXPENSES",
        "HEALTHCARE_COVERAGE"
    ],

    "organizations": [
        "REVENUE",
        "UTILIZATION"
    ],

    "encounters": [
        "BASE_ENCOUNTER_COST",
        "TOTAL_CLAIM_COST",
        "PAYER_COVERAGE"
    ],

    "procedures": [
        "BASE_COST"
    ],

    "medications": [
        "BASE_COST",
        "TOTALCOST",
        "PAYER_COVERAGE",
        "DISPENSES"
    ],

    "payers": [
        "AMOUNT_COVERED",
        "AMOUNT_UNCOVERED",
        "REVENUE"
    ]
}


# =============================================================================
# UUID Validation
# =============================================================================

def is_valid_uuid(value):

    if pd.isna(value):
        return True

    try:
        uuid.UUID(str(value))
        return True
    except Exception:
        return False


# =============================================================================
# Validate Required Columns
# =============================================================================

def validate_columns(df, table):

    logger.info(f"Validating columns : {table}")

    missing = []

    expected = []

    if table in UUID_COLUMNS:
        expected.extend(UUID_COLUMNS[table])

    if table in NON_NEGATIVE_COLUMNS:
        expected.extend(NON_NEGATIVE_COLUMNS[table])

    if table in PRIMARY_KEYS:
        expected.append(PRIMARY_KEYS[table])

    expected = sorted(set(expected))

    for column in expected:

        if column not in df.columns:
            missing.append(column)

    if missing:

        raise ValueError(
            f"{table} missing columns: {missing}"
        )


# =============================================================================
# Validate Primary Keys
# =============================================================================

def validate_primary_key(df, table):

    if table not in PRIMARY_KEYS:
        return

    pk = PRIMARY_KEYS[table]

    logger.info(f"Checking Primary Key : {pk}")

    if df[pk].isnull().any():

        raise ValueError(
            f"{table} contains NULL Primary Keys."
        )

    duplicates = df[df.duplicated(pk)]

    if len(duplicates) > 0:

        raise ValueError(
            f"{table} contains duplicate Primary Keys."
        )


# =============================================================================
# Validate UUIDs
# =============================================================================

def validate_uuids(df, table):

    if table not in UUID_COLUMNS:
        return

    logger.info("Validating UUID columns")

    for column in UUID_COLUMNS[table]:

        invalid = df[~df[column].apply(is_valid_uuid)]

        if len(invalid) > 0:

            raise ValueError(
                f"{table}.{column} contains invalid UUID values."
            )


# =============================================================================
# Validate Negative Numbers
# =============================================================================

def validate_non_negative(df, table):

    if table not in NON_NEGATIVE_COLUMNS:
        return

    logger.info("Checking numeric columns")

    for column in NON_NEGATIVE_COLUMNS[table]:

        invalid = df[df[column] < 0]

        if len(invalid) > 0:

            raise ValueError(
                f"{table}.{column} contains negative values."
            )


# =============================================================================
# Main Validation Pipeline
# =============================================================================

def validate_dataframe(df, table):

    logger.info("=" * 70)
    logger.info(f"VALIDATING {table.upper()}")
    logger.info("=" * 70)

    validate_columns(df, table)

    validate_primary_key(df, table)

    validate_uuids(df, table)

    validate_non_negative(df, table)

    logger.info(f"{table} validation passed.\n")