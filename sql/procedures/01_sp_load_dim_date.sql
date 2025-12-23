USE ROLE ACCOUNTADMIN;
USE DATABASE ZOMATO_DWH;
USE SCHEMA UTIL;

CREATE OR REPLACE PROCEDURE SP_LOAD_DIM_DATE()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
try {
  snowflake.execute({ sqlText: 'BEGIN' });

  snowflake.execute({
    sqlText: `TRUNCATE TABLE ZOMATO_DWH.INT.DIM_DATE`
  });

  var insertSql = `
    INSERT INTO ZOMATO_DWH.INT.DIM_DATE (
      DATE_KEY, FULL_DATE, YEAR, MONTH, MONTH_SHORT,
      DAY_OF_MONTH, DAY_OF_WEEK, DAY_OF_WEEK_SHORT, WEEK_OF_YEAR
    )
    WITH date_range AS (
      SELECT DATEADD('day', SEQ4(), '2019-01-01'::DATE) AS d
      FROM TABLE(GENERATOR(ROWCOUNT => 365 * 10))
    )
    SELECT
      TO_NUMBER(TO_CHAR(d,'YYYYMMDD')),
      d, YEAR(d), MONTH(d), TO_CHAR(d,'MON'),
      DAY(d), DAYOFWEEK(d), TO_CHAR(d,'DY'), WEEKOFYEAR(d)
    FROM date_range
    WHERE d <= '2028-12-31'::DATE
  `;

  snowflake.execute({ sqlText: insertSql });
  snowflake.execute({ sqlText: 'COMMIT' });

  return 'SP_LOAD_DIM_DATE completed successfully';
} catch (err) {
  snowflake.execute({ sqlText: 'ROLLBACK' });
  return 'ERROR in SP_LOAD_DIM_DATE: ' + err;
}
$$;
