view: vw_theobrama_gsc_branded {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobrama_GSC_Branded` ;;

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
    type: sum
    sql: ${TABLE}.avg_position ;;
    value_format: "#,##0.00"
  }

  measure: ctr {
    type: number
    label: "CTR"
    sql: SAFE_DIVIDE(${clicks}, ${impressions}) ;;
    value_format: "0.00%"
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }
  measure: count {
    type: count
  }
}
