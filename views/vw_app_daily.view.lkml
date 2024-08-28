# The name of this view in Looker is "Vw App Daily"
view: app_daily {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: (SELECT *,GENERATE_UUID() as primary_key  FROM `puretech-edw.Theobroma.VW_App_Daily`);;


  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.primary_key ;;
  }


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

  measure: first_open_count {
    type: sum
    sql: ${TABLE}.first_open_count ;;
  }

  measure: purchase_count {
    type: sum
    sql: ${TABLE}.purchase_count ;;
  }

  measure: spends {
    type: sum
    sql: ${TABLE}.spends ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: add_to_cart_count {
    type: sum
    sql: ${TABLE}.add_to_cart_count ;;
  }

  measure: cost_per_first_open {
    type: number
    sql: SAFE_DIVIDE(${spends},${first_open_count}) ;;
    value_format: "#,##0"
    html: @{currency}{{rendered_value}} ;;
  }

  measure: cost_per_purchase {
    type: number
    sql: ${spends} / NULLIF(${purchase_count}, 0) ;;
   value_format: "#,##0"
    html: @{currency}{{rendered_value}} ;;
  }

  measure: roas {
    type: number
    sql: SAFE_DIVIDE(${total_revenue},${spends});;
   value_format: "0.0%"
  }
}
