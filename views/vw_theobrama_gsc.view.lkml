view: vw_theobrama_gsc {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GSC` ;;

  measure: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
  }
  measure: ctr {
    type: number
    sql: ${TABLE}.ctr ;;
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
    type: number
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }
  measure: position {
    type: number
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
