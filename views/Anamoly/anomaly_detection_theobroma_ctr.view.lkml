view: vw_anomaly_detection_theobroma_ctr {

  derived_table: {
    sql:
      SELECT
        *,
        GENERATE_UUID() AS primary_key
      FROM `puretech-edw.Theobroma_Anomaly_Detection.anomaly_detection_Theobroma_CTR`
    ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.primary_key ;;
  }

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

  dimension: theobroma_ctr {
    type: number
    sql: ${TABLE}.Theobroma_CTR ;;
    value_format: "0.00%"
  }

  measure: ctr_anomaly {
    type: average
    sql: CASE WHEN ${is_anomaly} THEN ${TABLE}.Theobroma_CTR END ;;
    value_format: "0.00%"
    label: "CTR (Anomaly)"
  }

  measure: ctr_non_anomaly {
    type: average
    sql: CASE WHEN NOT ${is_anomaly} THEN ${TABLE}.Theobroma_CTR END ;;
    value_format: "0.00%"
    label: "CTR (Non-Anomaly)"
  }

  measure: upper_bound {
    type: average
    sql: ${TABLE}.upper_bound ;;
    value_format: "0.00%"
    label: "Upper Bound"
  }

  measure: lower_bound {
    type: average
    sql: CASE WHEN ${TABLE}.lower_bound < 0 THEN 0 ELSE ${TABLE}.lower_bound END ;;
    value_format: "0.00%"
    label: "Lower Bound"
  }

  measure: count {
    type: count
  }
}
