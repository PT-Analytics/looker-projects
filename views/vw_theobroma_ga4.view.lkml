view: vw_theobroma_ga4 {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobroma_GA4` ;;

  # -------- Dimensions (for grouping) --------
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }

  dimension: session_manual_campaign_name {
    type: string
    sql: ${TABLE}.session_manual_campaign_name ;;
  }

  dimension: session_source_medium {
    type: string
    sql: ${TABLE}.session_source_medium ;;
  }

  # -------- Measures (metrics) --------

  measure: add_to_carts {
    type: sum
    sql: ${TABLE}.add_to_carts ;;
    value_format_name: decimal_0
  }

  measure: checkouts {
    type: sum
    sql: ${TABLE}.checkouts ;;
    value_format_name: decimal_0
  }

  measure: screen_page_views {
    type: sum
    sql: ${TABLE}.screen_page_views ;;
    value_format_name: decimal_0
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format_name: decimal_0
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.totalrevenue ;;
    value_format_name: decimal_2
  }

  measure: transactions {
    type: sum
    sql: ${TABLE}.transactions ;;
    value_format_name: decimal_0
  }
  measure: cr_percent {
    label: "CR%"
    type: number
    value_format: "0.00%"
    sql: SAFE_DIVIDE(${transactions}, ${sessions}) ;;
  }

  ## AOV = Revenue / Purchases
  measure: aov {
    label: "AOV"
    type: number
    value_format: "#,##0"
    sql: SAFE_DIVIDE(${total_revenue}, ${transactions}) ;;
  }
  # Generic row count
  measure: count {
    type: count
    drill_fields: [session_manual_campaign_name]
  }
}
