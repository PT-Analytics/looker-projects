# The name of this view in Looker is "Vw Ga4 Trans Revenue"
view: ga4_transaction_revenue {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `puretech-edw.Theobroma.VW_GA4_Trans_Revenue` ;;


  dimension: __hevo_id {
    type: string
    sql: ${TABLE}.__hevo_id ;;
    primary_key:yes
    hidden:yes
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.session_manual_campaign_name ;;
  }

  dimension: source_medium {
    type: string
    sql: ${TABLE}.session_source_medium ;;
  }

  dimension: revenue_dim {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  dimension: transaction_dim {
    type: number
    sql: ${TABLE}.total_revenue ;;
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
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }


  measure: cpc_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    filters: [custom_source_medium: "cpc"]
    html: @{currency}{{rendered_value}} ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: transactions {
    type: sum
    sql: ${TABLE}.transactions ;;
  }

  measure: aov {
    type: number
    sql: SAFE_DIVIDE(${total_revenue},${transactions});;
    value_format: "#,##0"
    html: @{currency}{{rendered_value}} ;;
  }
}
