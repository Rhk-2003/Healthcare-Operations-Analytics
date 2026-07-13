/*
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar
Database: PostgreSQL
Script  : 01_create_schema.sql

Description:
Creates the dedicated schema for the Healthcare Operations Analytics Platform.

This project follows a layered architecture:

Raw CSV Files
        ↓
healthcare Schema (Raw Tables)
        ↓
Analytics Views
        ↓
Power BI Dashboards

The raw tables preserve the original Synthea column names.
Business-friendly naming will be implemented using SQL Views.

===============================================================================
*/

-- ============================================================================
-- Create Healthcare Schema
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS healthcare;

-- ============================================================================
-- Set Default Schema
-- ============================================================================

SET search_path TO healthcare;

-- ============================================================================
-- Verify Schema Creation
-- ============================================================================

SELECT CURRENT_SCHEMA();