# The name of this view in Looker is "Vw Firebase Revenue"
view: firebase_revenue {

  sql_table_name: `puretech-edw.Theobroma.VW_Firebase_Revenue` ;;



  dimension: __hevo_id {
    type: string
    sql: ${TABLE}.__hevo_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.session_campaign_name ;;
  }

  dimension: source_medium {
    type: string
    sql: ${TABLE}.session_source_medium ;;
  }

  dimension: custom_source_medium {
    type: string
    case:    {
      when: {
        sql: ${source_medium} LIKE '%cpc%';;
        label: "cpc"
      }
      else: "Others"
    }
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: cpc_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    filters: [custom_source_medium: "cpc"]
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: transactions {
    type: sum
    sql: ${TABLE}.transactions ;;

  }
}
