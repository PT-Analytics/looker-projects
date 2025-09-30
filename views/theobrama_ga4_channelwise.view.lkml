view: theobrama_ga4_channelwise {
  sql_table_name: `puretech-edw.Theobroma.Theobrama_GA4_Channelwise` ;;

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
  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "#,##0"
  }
  measure: totalusers {
    type: sum
    sql: ${TABLE}.totalusers ;;
    value_format: "#,##0"
  }
  measure: count {
    type: count
  }
}
