view: vw_theobrama_gsc_exlude_query {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GSC_ExludeQuery` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }

  measure: avg_position {
    type: average
    sql: ${TABLE}.avg_position ;;
    value_format: "#,##0.0"
  }

  measure: ctr {
    type: number
    label: "CTR"
    sql: SAFE_DIVIDE(${clicks}, ${impressions}) ;;
    value_format: "0.00%"
  }

  measure: count {
    type: count
  }
}
