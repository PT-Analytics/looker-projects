view: vw_theobroma_google_meta {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobroma_Google_Meta` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: week_of_month_label {
    type: string
    sql:
      CONCAT(
        'Week ',
        CAST(CEIL(EXTRACT(DAY FROM ${date_date}) / 7) AS STRING),
        ' of ',
        FORMAT_DATE('%b \'%y', ${date_date})
      )
    ;;
  }

  ## Month Format → August, September, ...
  dimension: month_name {
    type: string
    sql: FORMAT_DATE('%B %Y', ${date_date}) ;;
  }
  # -------- Dimensions -------- #
  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  # -------- Measures -------- #

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
    html: @{currency}{{rendered_value}} ;;
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

  # ---------- Calculated Metrics ---------- #

  measure: cpc {
    label: "CPC"
    type: number
    sql: SAFE_DIVIDE(${cost}, NULLIF(${clicks}, 0)) ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0.00"
  }

  measure: ctr {
    label: "CTR "
    type: number
    sql: SAFE_DIVIDE(${clicks}, NULLIF(${impressions}, 0)) * 100 ;;
    value_format: "0.00%"
  }

  measure: click_to_session {
    label: "Click to Session %"
    type: number
    sql: SAFE_DIVIDE(${sessions}, NULLIF(${clicks}, 0)) * 100 ;;
    value_format: "0.00%"
  }

  measure: analytics_roas {
    label: "Analytics ROAS"
    type: number
    sql: SAFE_DIVIDE(${purchase_revenue}, NULLIF(${cost}, 0)) ;;
    value_format: "#,##0"
  }

  measure: cr {
    label: "CR "
    type: number
    sql: SAFE_DIVIDE(${ecommerce_purchases}, NULLIF(${sessions}, 0)) * 100 ;;
    value_format: "0.00%"
  }

  measure: cpt {
    label: "CPT"
    type: number
    sql: SAFE_DIVIDE(${cost}, NULLIF(${transactions}, 0)) ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0.00"
  }

  measure: aov {
    label: "AOV"
    type: number
    sql: SAFE_DIVIDE(${purchase_revenue}, NULLIF(${transactions}, 0)) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
  }
}
