-- =====================================================
-- File: snowpipe_orders.sql
-- Purpose: Load order data from internal stage to RAW_ORDER
-- Layer: Ingestion
-- =====================================================

CREATE OR REPLACE PIPE zomato_orders_pipe
AS
COPY INTO RAW_ORDER
FROM @zomato_internal_stage/orders
FILE_FORMAT = zomato_csv_ff
ON_ERROR = 'CONTINUE';
