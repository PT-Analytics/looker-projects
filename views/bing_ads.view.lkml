# The name of this view in Looker is "Bing Campaign Performance Report"
view: bing_ads {

  sql_table_name: `puretech-edw.Theobroma.bing_campaign_performance_report` ;;


  dimension: __hevo_id {
    type: string
    description: "{\"dl\":\"512\",\"pk_p\":\"0\"}"
    sql: ${TABLE}.__hevo_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: location {

    type: string
    case:    {
      when: {
        sql: ${campaign_name} LIKE '%Mumbai-mum%';;
        label: "Mumbai"
      }
      when: {
        sql: ${campaign_name} LIKE '%Delhi%';;
        label: "Delhi"
      }
      when: {
        sql: ${campaign_name} LIKE '%Bangalore%';;
        label: "Banglore"
      }
      when: {
        sql: ${campaign_name} LIKE '%Pune%';;
        label: "Pune"
      }
      when: {
        sql: ${campaign_name} LIKE '%Hyderabad%';;
        label: "Hyderabad"
      }
      when: {
        sql: ${campaign_name} LIKE '%Chennai%';;
        label: "Chennai"
      }
      when: {
        sql: ${campaign_name} LIKE '%Chandigarh%';;
        label: "Chandigarh"
      }
      else: "Others"
    }
  }


  dimension: campaign_name {
    type: string
    description: "{\"dl\":\"512\"}"
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: clicks {
    type: number
    description: "{\"dl\":\"1\"}"
    sql: ${TABLE}.clicks ;;
  }

  dimension_group: date {
    type: time
    description: "{\"dl\":\"10\"}"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date ;;
  }

  dimension: impressions {
    type: number
    description: "{\"dl\":\"3\"}"
    sql: ${TABLE}.impressions ;;
  }

  dimension: spend {
    type: number
    description: "{\"dl\":\"38\",\"scale\":\"9\"}"
    sql: ${TABLE}.spend ;;
  }

  measure: total_ad_spend {
    type: sum
    sql: ${TABLE}.spend;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: total_impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }

  measure: total_clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
  }

  measure: revenue {
    type: sum_distinct
    sql: ${ga4_transaction_revenue.revenue_dim} ;;
    sql_distinct_key: ${ga4_transaction_revenue.__hevo_id}  ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
    filters: [ga4_transaction_revenue.source_medium: "bing / cpc"]
  }

  measure: transactions {
    type: sum_distinct
    sql: ${ga4_transaction_revenue.transaction_dim} ;;
    sql_distinct_key: ${ga4_transaction_revenue.__hevo_id}  ;;
    value_format: "#,##0"
    filters: [ga4_transaction_revenue.source_medium: "bing / cpc"]
  }

  measure: roas {
    type: number
    sql: SAFE_DIVIDE(${revenue},${total_ad_spend}) ;;
    value_format: "0%"
  }

  measure: cost_per_transactions {
    type: number
    sql: SAFE_DIVIDE(${total_ad_spend},${transactions}) ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }
}
