view: vw_theobroma_non_boverall {
  sql_table_name: `puretech-edw.Theobroma.Vw_Theobroma_NonBOverall` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  measure: non_branded_clicks {
    type: sum
    sql: ${TABLE}.non_branded_clicks ;;
    value_format: "#,##0"
  }
  measure: non_branded_impressions {
    type: sum
    sql: ${TABLE}.non_branded_impressions ;;
    value_format: "#,##0"
  }
  measure: non_branded_positon {
    type: sum
    sql: ${TABLE}.non_branded_positon ;;
    value_format: "#,##0.00"
  }
  measure: non_banded_ctr {
    type: number
    sql: SAFE_DIVIDE(${non_branded_clicks}, ${non_branded_impressions}) ;;
    value_format: "0.00%"
  }
  measure: count {
    type: count
  }
}
