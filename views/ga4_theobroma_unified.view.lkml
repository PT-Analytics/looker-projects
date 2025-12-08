view: ga4_theobroma_unified {
  sql_table_name: `puretech-edw.Theobroma.GA4_Theobroma_unified` ;;

  dimension: add_to_carts {
    type: number
    sql: ${TABLE}.add_to_carts ;;
  }
  dimension: checkouts {
    type: number
    sql: ${TABLE}.checkouts ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: screen_page_views {
    type: number
    sql: ${TABLE}.screen_page_views ;;
  }
  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }
  dimension: session_manual_campaign_name {
    type: string
    sql: ${TABLE}.session_manual_campaign_name ;;
  }
  dimension: session_source_medium {
    type: string
    sql: ${TABLE}.session_source_medium ;;
  }
  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }
  dimension: totalrevenue {
    type: number
    sql: ${TABLE}.totalrevenue ;;
  }
  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }
  measure: count {
    type: count
    drill_fields: [session_manual_campaign_name]
  }
}
