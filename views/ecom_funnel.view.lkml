# The name of this view in Looker is "Vw Ecom Funnel"
view: ecom_funnel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `puretech-edw.Theobroma.VW_Ecom_Funnel` ;;


  dimension: hevo_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.__hevo_id ;;
  }


  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: session_medium {
    type: string
    sql: ${TABLE}.session_medium ;;
  }

  dimension: session_source {
    type: string
    sql: ${TABLE}.session_source ;;
  }

  dimension: session_source_medium {
    type: string
    sql: ${TABLE}.session_source_medium ;;
  }

  measure: event_count {
    type: sum
    sql: ${TABLE}.event_count ;;
  }

  measure: session_start {
    type: count_distinct
    sql: ${hevo_id} ;;
    filters: [event_name: "session_start"]
  }

  measure: view_item {
    type: count_distinct
    sql: ${hevo_id} ;;
    filters: [event_name: "view_item"]
  }

  measure: add_to_cart {
    type: count_distinct
    sql: ${hevo_id} ;;
    filters: [event_name: "add_to_cart"]
  }

  measure: begin_checkout {
    type: count_distinct
    sql: ${hevo_id} ;;
    filters: [event_name: "begin_checkout"]
  }

  measure: purchase {
    type: count_distinct
    sql: ${hevo_id} ;;
    filters: [event_name: "purchase"]
  }

}
