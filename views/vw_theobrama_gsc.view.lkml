view: vw_theobrama_gsc {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GSC` ;;

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
  }
  measure: ctr {
    type: average
    sql: ${TABLE}.ctr ;;
    label: "CTR"
    value_format: "0.00%"
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }
  measure: position {
    type: sum
    sql: ${TABLE}.position ;;
    value_format: "#,##0.00"
  }
  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }
  measure: count {
    type: count
  }
}
