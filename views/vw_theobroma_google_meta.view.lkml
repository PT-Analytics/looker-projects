view: vw_theobroma_google_meta {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobroma_Google_Meta` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  # -------- Measures (Converted from Dimensions) -------- #

  measure: campaign {
    type: count_distinct
    sql: ${TABLE}.campaign ;;
  }

  measure: campaign_name {
    type: count_distinct
    sql: ${TABLE}.campaign_name ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
  }

  measure: conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
    value_format: "#,##0"
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "#,##0.00"
  }

  measure: ecommerce_purchases {
    type: sum
    sql: ${TABLE}.ecommerce_purchases ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }

  measure: platform {
    type: count_distinct
    sql: ${TABLE}.platform ;;
  }

  measure: purchase_revenue {
    type: sum
    sql: ${TABLE}.purchase_revenue ;;
    value_format: "#,##0.00"
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "#,##0"
  }

  measure: transactions {
    type: sum
    sql: ${TABLE}.transactions ;;
    value_format: "#,##0"
  }

  measure: count {
    type: count
  }
}
