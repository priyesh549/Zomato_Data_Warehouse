-- =====================================================
-- Purpose: Internal stage for Zomato ingestion
-- =====================================================

CREATE OR REPLACE STAGE zomato_internal_stage
    FILE_FORMAT = zomato_csv_ff;
