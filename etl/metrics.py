"""
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar

File    : metrics.py

Description:
Collects ETL execution metrics and prints a final execution summary.

Responsibilities
----------------
✓ Track rows loaded
✓ Track execution time
✓ Track success/failure
✓ Generate ETL summary
===============================================================================
"""

from dataclasses import dataclass, field
from datetime import datetime
from typing import List

from logger import logger


# =============================================================================
# Individual Table Metrics
# =============================================================================

@dataclass
class TableMetric:

    table: str

    rows: int

    duration: float

    status: str

    error: str = ""


# =============================================================================
# ETL Metrics Collector
# =============================================================================

@dataclass
class ETLMetrics:

    start_time: datetime = field(default_factory=datetime.now)

    metrics: List[TableMetric] = field(default_factory=list)

    def add_success(self,
                    table,
                    rows,
                    duration):

        self.metrics.append(

            TableMetric(

                table=table,

                rows=rows,

                duration=duration,

                status="SUCCESS"

            )

        )

    def add_failure(self,
                    table,
                    error,
                    duration=0):

        self.metrics.append(

            TableMetric(

                table=table,

                rows=0,

                duration=duration,

                status="FAILED",

                error=str(error)

            )

        )

    @property
    def total_rows(self):

        return sum(m.rows for m in self.metrics)

    @property
    def successful_tables(self):

        return len(

            [m for m in self.metrics

             if m.status == "SUCCESS"]

        )

    @property
    def failed_tables(self):

        return len(

            [m for m in self.metrics

             if m.status == "FAILED"]

        )

    @property
    def total_tables(self):

        return len(self.metrics)

    @property
    def total_duration(self):

        return (

            datetime.now()

            - self.start_time

        ).total_seconds()

    # =========================================================================
    # Print Summary
    # =========================================================================

    def summary(self):

        logger.info("")

        logger.info("=" * 90)

        logger.info("ETL EXECUTION SUMMARY")

        logger.info("=" * 90)

        logger.info(

            f"{'Table':20}"

            f"{'Rows':>15}"

            f"{'Time(s)':>15}"

            f"{'Status':>15}"

        )

        logger.info("-" * 90)

        for m in self.metrics:

            logger.info(

                f"{m.table:20}"

                f"{m.rows:>15,}"

                f"{m.duration:>15.2f}"

                f"{m.status:>15}"

            )

        logger.info("-" * 90)

        logger.info(f"Tables Loaded : {self.successful_tables}/{self.total_tables}")

        logger.info(f"Failed Tables : {self.failed_tables}")

        logger.info(f"Total Rows    : {self.total_rows:,}")

        logger.info(f"Total Time    : {self.total_duration:.2f} sec")

        logger.info("=" * 90)

        if self.failed_tables:

            logger.info("")

            logger.info("FAILED TABLES")

            logger.info("-" * 90)

            for m in self.metrics:

                if m.status == "FAILED":

                    logger.info(

                        f"{m.table} : {m.error}"

                    )

            logger.info("-" * 90)