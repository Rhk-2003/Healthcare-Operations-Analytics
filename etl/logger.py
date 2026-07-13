"""
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar

File    : logger.py

Description:
Central logging configuration for the ETL pipeline.
===============================================================================
"""

import logging
import os
from datetime import datetime

# =============================================================================
# Create Logs Directory
# =============================================================================

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOG_DIR = os.path.join(BASE_DIR, "logs")

os.makedirs(LOG_DIR, exist_ok=True)

# =============================================================================
# Log File
# =============================================================================

log_file = os.path.join(
    LOG_DIR,
    f"etl_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
)

# =============================================================================
# Logger
# =============================================================================

logger = logging.getLogger("synthea_etl")
logger.setLevel(logging.INFO)
logger.propagate = False

logger.handlers.clear()

formatter = logging.Formatter(
    "%(asctime)s | %(levelname)-8s | %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)

# Console Output

console_handler = logging.StreamHandler()
console_handler.setFormatter(formatter)

# File Output

file_handler = logging.FileHandler(
    log_file,
    encoding="utf-8"
)

file_handler.setFormatter(formatter)

logger.addHandler(console_handler)
logger.addHandler(file_handler)