view: vw_theobrama_ga4_channelwise_new {
  sql_table_name: `puretech-edw.Theobroma.vw_theobrama_ga4_channelwise_New` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: paid_media_channel {
    type: string
    sql:
    CASE
      WHEN ${TABLE}.`Paid Search` > 0 THEN 'Paid Search'
      WHEN ${TABLE}.`Paid Social` > 0 THEN 'Paid Social'
      WHEN ${TABLE}.`Paid Video` > 0 THEN 'Paid Video'
      WHEN ${TABLE}.`Paid Shopping` > 0 THEN 'Paid Shopping'
      WHEN ${TABLE}.`Paid Other` > 0 THEN 'Paid Other'
      WHEN ${TABLE}.Display > 0 THEN 'Display'
      ELSE NULL
    END ;;
    label: "Paid Media Channel"

  }


  # Measures instead of dimensions
  measure: crossnetwork {
    type: sum
    sql: ${TABLE}.`Cross-network` ;;
    value_format: "#,##0"
  }

  measure: direct {
    type: sum
    sql: ${TABLE}.Direct ;;
    value_format: "#,##0"
  }

  measure: display {
    type: sum
    sql: ${TABLE}.Display ;;
    value_format: "#,##0"
  }

  measure: email {
    type: sum
    sql: ${TABLE}.Email ;;
    value_format: "#,##0"
  }

  measure: organic_search {
    type: sum
    sql: ${TABLE}.`Organic Search` ;;
    value_format: "#,##0"
  }

  measure: organic_shopping {
    type: sum
    sql: ${TABLE}.`Organic Shopping` ;;
    value_format: "#,##0"
  }

  measure: organic_social {
    type: sum
    sql: ${TABLE}.`Organic Social` ;;
    value_format: "#,##0"
  }

  measure: organic_video {
    type: sum
    sql: ${TABLE}.`Organic Video` ;;
    value_format: "#,##0"
  }

  measure: paid_other {
    type: sum
    sql: ${TABLE}.`Paid Other` ;;
    value_format: "#,##0"
  }

  measure: paid_search {
    type: sum
    sql: ${TABLE}.`Paid Search` ;;
    value_format: "#,##0"
  }

  measure: paid_shopping {
    type: sum
    sql: ${TABLE}.`Paid Shopping` ;;
    value_format: "#,##0"
  }

  measure: paid_social {
    type: sum
    sql: ${TABLE}.`Paid Social` ;;
    value_format: "#,##0"
  }

  measure: paid_video {
    type: sum
    sql: ${TABLE}.`Paid Video` ;;
    value_format: "#,##0"
  }

  measure: referral {
    type: sum
    sql: ${TABLE}.Referral ;;
    value_format: "#,##0"
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "#,##0"
  }

  measure: sms {
    type: sum
    sql: ${TABLE}.SMS ;;
    value_format: "#,##0"
  }

  measure: total_users {
    type: sum
    sql: ${TABLE}.totalusers ;;
    value_format: "#,##0"
  }

  measure: unassigned {
    type: sum
    sql: ${TABLE}.Unassigned ;;
    value_format: "#,##0"
  }

  measure: count {
    type: count
  }
}
