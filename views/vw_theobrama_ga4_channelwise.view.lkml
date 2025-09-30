view: vw_theobrama_ga4_channelwise {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GA4_Channelwise` ;;

  # ----------------
  # Time dimension
  # ----------------
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  # ----------------
  # Measures (metrics)
  # ----------------
  measure: cross_network_sessions {
    type: sum
    sql: ${TABLE}.cross_network_sessions ;;
    value_format: "#,##0"
  }

  measure: direct_sessions {
    type: sum
    sql: ${TABLE}.direct_sessions ;;
    value_format: "#,##0"
  }

  measure: display_sessions {
    type: sum
    sql: ${TABLE}.display_sessions ;;
    value_format: "#,##0"
  }

  measure: organic_sessions {
    type: sum
    sql: ${TABLE}.organic_sessions ;;
    value_format: "#,##0"
  }

  measure: organic_shopping_sessions {
    type: sum
    sql: ${TABLE}.organic_shopping_sessions ;;
    value_format: "#,##0"
  }

  measure: organic_social_sessions {
    type: sum
    sql: ${TABLE}.organic_social_sessions ;;
    value_format: "#,##0"
  }

  measure: other_advertising_sessions {
    type: sum
    sql: ${TABLE}.other_advertising_sessions ;;
    value_format: "#,##0"
  }

  measure: paid_sessions {
    type: sum
    sql: ${TABLE}.paid_sessions ;;
    value_format: "#,##0"
  }

  measure: paid_shopping_sessions {
    type: sum
    sql: ${TABLE}.paid_shopping_sessions ;;
    value_format: "#,##0"
  }

  measure: paid_video_sessions {
    type: sum
    sql: ${TABLE}.paid_video_sessions ;;
    value_format: "#,##0"
  }

  measure: referral_sessions {
    type: sum
    sql: ${TABLE}.referral_sessions ;;
    value_format: "#,##0"
  }

  measure: social_paid_sessions {
    type: sum
    sql: ${TABLE}.social_paid_sessions ;;
    value_format: "#,##0"
  }

  measure: total_sessions {
    type: sum
    sql: ${TABLE}.total_sessions ;;
    value_format: "#,##0"
  }

  measure: total_users {
    type: sum
    sql: ${TABLE}.total_users ;;
    value_format: "#,##0"
  }

  measure: unassigned_sessions {
    type: sum
    sql: ${TABLE}.unassigned_sessions ;;
    value_format: "#,##0"
  }

  # ----------------
  # Utility
  # ----------------
  measure: row_count {
    type: count
  }
}
