view: vw_anomaly_detection_theobroma_cost {

  derived_table: {
    sql:
      SELECT
        *,
        GENERATE_UUID() AS primary_key
      FROM `puretech-edw.Theobroma_Anomaly_Detection.anomaly_detection_Theobroma_Cost`
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

  dimension: theobroma_cost {
    type: number
    sql: ${TABLE}.Theobroma_Cost ;;
  }

  measure: cost_anomaly {
    type: sum
    sql: CASE WHEN ${is_anomaly} THEN ${TABLE}.Theobroma_Cost END ;;
    value_format: "#,##0"
    label: "Cost (Anomaly)"
  }

  measure: cost_non_anomaly {
    type: sum
    sql: CASE WHEN NOT ${is_anomaly} THEN ${TABLE}.Theobroma_Cost END ;;
    value_format: "#,##0"
    label: "Cost (Non-Anomaly)"
  }

  measure: upper_bound {
    type: sum
    sql: ${TABLE}.upper_bound ;;
    value_format: "#,##0"
  }

  measure: lower_bound {
    type: sum
    sql: CASE WHEN ${TABLE}.lower_bound < 0 THEN 0 ELSE ${TABLE}.lower_bound END ;;
    value_format: "#,##0"
  }

  measure: count {
    type: count
  }
}
