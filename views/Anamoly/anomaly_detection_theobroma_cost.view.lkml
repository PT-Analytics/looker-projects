view: anomaly_detection_theobroma_cost {
  sql_table_name: `puretech-edw.Theobroma_Anomaly_Detection.anomaly_detection_Theobroma_Cost` ;;

  dimension: anomaly_probability {
    type: number
    sql: ${TABLE}.anomaly_probability ;;
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: is_anomaly {
    type: yesno
    sql: ${TABLE}.is_anomaly ;;
  }
  dimension: lower_bound {
    type: number
    sql: ${TABLE}.lower_bound ;;
  }
  dimension: theobroma_cost {
    type: number
    sql: ${TABLE}.Theobroma_Cost ;;
  }
  dimension: upper_bound {
    type: number
    sql: ${TABLE}.upper_bound ;;
  }
  measure: count {
    type: count
  }
}
