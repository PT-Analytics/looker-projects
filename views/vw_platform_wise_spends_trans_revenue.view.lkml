# The name of this view in Looker is "Vw Platform Wise Spends Trans Revenue"
view: platform_wise_spends_trans_revenue {

  sql_table_name: (SELECT *,GENERATE_UUID() as primary_key  FROM `puretech-edw.Theobroma.VW_Platform_Wise_Spends_Trans_Revenue` );;


  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.primary_key ;;
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: total_spends {
    type: sum
    sql: ${TABLE}.total_spends ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: total_transactions {
    type: sum
    sql: ${TABLE}.total_transactions ;;
    value_format: "#,##0"
  }

  measure: roas {
    type: number
    sql: SAFE_DIVIDE(${total_revenue},${total_spends});;
    value_format: "0%"
  }

}
