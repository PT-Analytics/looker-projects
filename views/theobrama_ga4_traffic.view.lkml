view: theobrama_ga4_traffic {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GA4_Traffic` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: new_vs_returning {
    type: string
    sql: ${TABLE}.new_vs_returning ;;
  }

  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }

  ## Measures (converted from dimensions)
  measure: active_users {
    type: sum
    sql: ${TABLE}.active_users ;;
    value_format: "#,##0"
  }

  measure: average_session_duration {
    type: average
    sql: ${TABLE}.average_session_duration ;;
    value_format: "#,##0.00"
  }

  measure: bounce_rate {
    type: average
    sql: ${TABLE}.bounce_rate ;;
    value_format: "0.00%"
  }

  measure: engagement_rate {
    type: average
    sql: ${TABLE}.engagement_rate ;;
    value_format: "0.00%"
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

  measure: total_users {
    type: sum
    sql: ${TABLE}.totalusers ;;
    value_format: "#,##0"
  }

  measure: users {
    type: sum
    sql: ${TABLE}.users ;;
    value_format: "#,##0"
  }

  ## Default row counter
  measure: count {
    type: count
  }
}
