view: theobrama_ga4_device {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GA4_Device` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension: devicecategory {
    type: string
    sql: ${TABLE}.devicecategory ;;
    label: "Device category"
  }
  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }
  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "#,##0"
  }
  measure: count {
    type: count
  }
}
