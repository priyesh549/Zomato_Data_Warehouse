-- =====================================================
-- File: file_format.sql
-- Purpose: Define reusable file formats for ingestion
-- =====================================================

CREATE OR REPLACE FILE FORMAT zomato_csv_ff
    TYPE = CSV
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    TRIM_SPACE = TRUE
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE;

-- For semi-structured app events (if any)
CREATE OR REPLACE FILE FORMAT zomato_json_ff
    TYPE = JSON
    STRIP_OUTER_ARRAY = TRUE;
