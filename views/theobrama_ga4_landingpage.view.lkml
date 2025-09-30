view: theobrama_ga4_landingpage {
  sql_table_name: `puretech-edw.Theobroma.Theobrama_GA4_Landingpage` ;;

  # --- Date ---
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  # --- Dimensions ---
  dimension: landing_page {
    type: string
    sql: ${TABLE}.landing_page ;;
  }

  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }

  # --- Measures ---
  measure: average_session_duration {
    type: average
    sql: ${TABLE}.average_session_duration ;;
    value_format: "#,##0.00"
  }

  measure: bounce_rate {
    type: average
    sql: CAST(${TABLE}.bounce_rate AS FLOAT64) ;;
    value_format: "0.00%"
  }

  measure: newusers {
    type: sum
    sql: ${TABLE}.newusers ;;
    value_format: "#,##0"
  }

  measure: screen_page_views {
    type: sum
    sql: ${TABLE}.screen_page_views ;;
    value_format: "#,##0"
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "#,##0"
  }

  measure: count {
    type: count
  }
}
