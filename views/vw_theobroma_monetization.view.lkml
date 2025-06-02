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
  }
  measure: add_to_carts {
    type: sum
    sql: ${TABLE}.add_to_carts ;;
  }
  measure: checkouts {
    type: sum
    sql: ${TABLE}.checkouts ;;
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }
  measure: conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
  }
  measure: conversions_value {
    type: sum
    sql: ${TABLE}.conversions_value ;;
  }
  measure: deficit_net_metric {
    type: sum
    sql: ${TABLE}.deficit_net_metric ;;
  }
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }
  measure: net_achieved_metric {
    type: sum
    sql: ${TABLE}.net_achieved_metric ;;
  }
  measure: screen_page_views {
    type: sum
    sql: ${TABLE}.screen_page_views ;;
  }
  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
  }
  measure: spends {
    type: sum
    sql: ${TABLE}.spends ;;
  }
  measure: target_net_metric {
    type: sum
    sql: ${TABLE}.target_net_metric ;;
  }
  measure: target_spends_metric {
    type: sum
    sql: ${TABLE}.target_spends_metric ;;
  }
  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
  }
  measure: transactions {
    type: sum
    sql: ${TABLE}.transactions ;;
  }

}
