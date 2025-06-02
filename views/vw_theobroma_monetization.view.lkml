view: vw_theobroma_monetization {
  sql_table_name: `puretech-edw.Theobroma.VW_Theobroma_Monetization` ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }
  dimension: category_1 {
    type: string
    sql: ${TABLE}.category_1 ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: location_search {
    type: string
    sql: ${TABLE}.location_search ;;
  }
  dimension: rn {
    type: number
    sql: ${TABLE}.rn ;;
  }
  measure: achieved_spends_metric {
    type: sum
    sql: ${TABLE}.achieved_spends_metric ;;
    value_format_name: decimal_1
  }
  measure: add_to_carts {
    type: sum
    sql: ${TABLE}.add_to_carts ;;
    value_format_name: decimal_1
  }
  measure: checkouts {
    type: sum
    sql: ${TABLE}.checkouts ;;
    value_format_name: decimal_1
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format_name: decimal_1
  }
  measure: conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
    value_format_name: decimal_1
  }
  measure: conversions_value {
    type: sum
    sql: ${TABLE}.conversions_value ;;
    value_format_name: decimal_1
  }
  measure: deficit_net_metric {
    type: sum
    sql: ${TABLE}.deficit_net_metric ;;
    value_format_name: decimal_1
  }
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format_name: decimal_1
  }
  measure: net_achieved_metric {
    type: sum
    sql: ${TABLE}.net_achieved_metric ;;
    value_format_name: decimal_1
  }
  measure: screen_page_views {
    type: sum
    sql: ${TABLE}.screen_page_views ;;
    value_format_name: decimal_1
  }
  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format_name: decimal_1
  }
  measure: spends {
    type: sum
    sql: ${TABLE}.spends ;;
    value_format_name: decimal_1
  }
  measure: target_net_metric {
    type: sum
    sql: ${TABLE}.target_net_metric ;;
    value_format_name: decimal_1
  }
  measure: target_spends_metric {
    type: sum
    sql: ${TABLE}.target_spends_metric ;;
    value_format_name: decimal_1
  }
  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    value_format_name: decimal_1
  }
  measure: transactions {
    type: sum
    sql: ${TABLE}.transactions ;;
    value_format_name: decimal_1
  }
  measure: cpc {
    type: number
    sql: CASE WHEN ${clicks} != 0 THEN ${spends} / ${clicks} ELSE 0 END ;;
    value_format_name: decimal_1
  }
  measure: ctr {
    type: number
    sql: CASE WHEN ${impressions} != 0 THEN ${spends} / ${impressions} ELSE 0 END ;;
    value_format_name: percent_1
  }
  measure: click_to_session{
    type: number
    sql: CASE WHEN ${clicks} != 0 THEN ${sessions} / ${clicks} ELSE 0 END ;;
    value_format_name: percent_1
  }
  measure: dashboard_roas{
    type: number
    sql: CASE WHEN ${spends} != 0 THEN ${conversions_value} / ${spends} ELSE 0 END ;;
    value_format_name: decimal_1
  }
  measure: analytics_roas{
    type: number
    sql: CASE WHEN ${spends} != 0 THEN ${total_revenue} / ${spends} ELSE 0 END ;;
    value_format_name: decimal_1
  }
  measure: conv_rate{
    type: number
    sql: CASE WHEN ${sessions} != 0 THEN ${transactions} / ${sessions} ELSE 0 END ;;
    value_format_name: percent_1
  }
  measure: cpt{
    type: number
    sql: CASE WHEN ${transactions} != 0 THEN ${spends} / ${transactions} ELSE 0 END ;;
    value_format_name: decimal_1
  }
  measure: aov{
    type: number
    sql: CASE WHEN ${transactions} != 0 THEN ${total_revenue} / ${transactions} ELSE 0 END ;;
    value_format_name: decimal_1
  }
  measure: cpm{
    type: number
    sql: CASE WHEN ${impressions} != 0 THEN ${spends} / (${impressions}*1000) ELSE 0 END ;;
    value_format_name: decimal_1
  }
}
