view: vw_conv_summary {
  sql_table_name: `puretech-edw.Theobroma.VW_Conv_Summary` ;;

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: unique_key {
    type: string
    sql: ${TABLE}.unique_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  measure: spends {
    type: sum
    sql: ${TABLE}.spends ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: transactions {
    type: sum
    sql: ${TABLE}.transac ;;
    value_format: "#,##0"
  }

  measure: cost_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${spends},${transactions});;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }
}
