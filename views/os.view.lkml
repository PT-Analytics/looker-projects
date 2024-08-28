# The name of this view in Looker is "Vw OS"
view: vw_os {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `puretech-edw.Theobroma.VW_OS` ;;

  dimension: __hevo_id {
    type: string
    sql: ${TABLE}.__hevo_id ;;
    primary_key: yes
    hidden: yes
  }


  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: operating_system {
    type: string
    sql: ${TABLE}.operating_system ;;
  }

  dimension: item_revenue {
    type: number
    sql: ${TABLE}.item_revenue ;;
  }


  measure: total_item_revenue {
    type: sum
    sql: ${item_revenue} ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }
}
