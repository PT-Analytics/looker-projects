# The name of this view in Looker is "Vw Item Revenue"
view: item_revenue {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `puretech-edw.Theobroma.VW_Item_Revenue` ;;

  dimension: __hevo_id {
    type: string
    sql: ${TABLE}.__hevo_id ;;
    primary_key: yes
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: item_category {
    type: string
    sql: ${TABLE}.item_category ;;
    drill_fields: [item_name]
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: item_revenue {
    type: number
    sql: ${TABLE}.item_revenue ;;
    hidden: yes
  }

  dimension: items_purchased {
    type: number
    sql: ${TABLE}.items_purchased ;;
    hidden: yes
  }

  measure: total_item_revenue {
    type: sum
    sql: ${item_revenue} ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: total_items_purchased {
    type: sum
    sql: items_purchased ;;
    value_format: "#,##0"
  }

  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }
}
