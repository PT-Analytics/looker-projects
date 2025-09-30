view: vw_theobrama_ga4_citywise {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GA4_Citywise` ;;

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
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
  measure: sessions{
    type: sum
    sql: ${TABLE}.sessions_int64 ;;
  }
  measure: count {
    type: count
  }
}
