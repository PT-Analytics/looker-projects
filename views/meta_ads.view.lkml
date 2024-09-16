# The name of this view in Looker is "Meta Ads Ad Insights Custom Report"
view: meta_ads {
  sql_table_name: `puretech-edw.Theobroma.meta_ads_ad_insights_custom_report` ;;


  dimension: __hevo_id {
    type: string
    description: "{\"dl\":\"512\",\"pk_p\":\"0\"}"
    sql: ${TABLE}.__hevo_id ;;
    primary_key: yes
    hidden: yes
  }
  # dimension: ad_id {
  #   type: number
  #   description: "{\"dl\":\"18\"}"
  #   sql: ${TABLE}.ad_id ;;
  # }

  # dimension: adset_id {
  #   type: number
  #   description: "{\"dl\":\"18\"}"
  #   sql: ${TABLE}.adset_id ;;
  # }

  # dimension: adset_name {
  #   type: string
  #   description: "{\"dl\":\"512\"}"
  #   sql: ${TABLE}.adset_name ;;
  # }

  # dimension: campaign_id {
  #   type: number
  #   description: "{\"dl\":\"17\"}"
  #   sql: ${TABLE}.campaign_id ;;
  # }

  dimension: campaign_name {
    type: string
    description: "{\"dl\":\"512\"}"
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_type {

    type: string
    case:    {
      when: {
        sql: ${campaign_name} LIKE '%-BOF-%';;
        label: "BOF"
      }
      when: {
        sql: ${campaign_name} LIKE '%-MOF-%';;
        label: "MOF"
      }
      when: {
        sql: ${campaign_name} LIKE '%-TOF-%';;
        label: "TOF"
      }
      else: "Others"
    }
  }

  dimension: modified_campaign_name {
    type: string
    sql: REGEXP_REPLACE(${TABLE}.campaign_name, r'\b[Tt]heo\b|\b[Tt]heobroma\b', 'Demo') ;;
    hidden: no
  }

  dimension: location {

    type: string
    case:    {
      when: {
        sql: ${campaign_name} LIKE '%Mumbai%';;
        label: "Mumbai"
      }
      when: {
        sql: ${campaign_name} LIKE '%Delhi%';;
        label: "Delhi"
      }
      when: {
        sql: ${campaign_name} LIKE '%Bangalore%';;
        label: "Bangalore"
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

  dimension_group: date {
    type: time
    description: "{\"dl\":\"28\"}"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_start ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: clicks {
    type: sum
    description: "{\"dl\":\"3\"}"
    sql: ${TABLE}.inline_link_clicks ;;
  }

  measure: total_ad_spend {
    type: sum
    sql: ${TABLE}.spend ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: unique_inline_link_clicks {
    type: sum
    description: "{\"dl\":\"3\"}"
    sql: ${TABLE}.unique_inline_link_clicks ;;
  }

  measure: revenue {
    type: sum_distinct
    sql: ${ga4_transaction_revenue.revenue_dim} ;;
    sql_distinct_key: ${ga4_transaction_revenue.__hevo_id}  ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
    filters: [ga4_transaction_revenue.source_medium: "facebook / cpc"]
  }

  measure: transactions {
    type: sum_distinct
    sql: ${ga4_transaction_revenue.transaction_dim} ;;
    sql_distinct_key: ${ga4_transaction_revenue.__hevo_id}  ;;
    value_format: "#,##0"
    filters: [ga4_transaction_revenue.source_medium: "facebook / cpc"]
  }

  measure: roas {
    type: number
    sql: SAFE_DIVIDE(${revenue},${total_ad_spend}) ;;
    value_format: "0.0%"
  }

  measure: cost_per_transactions {
    type: number
    sql: SAFE_DIVIDE(${total_ad_spend},${transactions}) ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0.0"
  }


}
