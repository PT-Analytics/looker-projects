# The name of this view in Looker is "Google Ads Campaign Custom0"
view: google_ads {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `puretech-edw.Theobroma.google_ads_campaign__custom0` ;;


  dimension: __hevo_id {
    primary_key: yes
    hidden: yes
    type: string
    description: "{\"dl\":\"512\",\"pk_p\":\"0\"}"
    sql: ${TABLE}.__hevo_id ;;
  }

  dimension: cost_micros {
    type: number
    description: "{\"dl\":\"10\"}"
    sql: ${TABLE}.cost_micros ;;
  }

  dimension: customer_id {
    type: string
    description: "{\"dl\":\"512\"}"
    sql: ${TABLE}.customer_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    description: "{\"dl\":\"10\"}"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date ;;
  }

  dimension: campaign_name {
    type: string
    description: "{\"dl\":\"512\"}"
    sql: ${TABLE}.name ;;
  }

  dimension: campaign_type {

    type: string
    case:    {
      when: {
        sql: ${campaign_name} LIKE '%-Brand-%';;
        label: "Brand"
      }
      when: {
        sql: ${campaign_name} LIKE '%-Core-%';;
        label: "Core"
      }
      when: {
        sql: ${campaign_name} LIKE '%-Performance-Max%' OR ${campaign_name} like '%-Pmax-%' OR ${campaign_name} like '%-pmax-%';;
        label: "PMAX"
      }
      when: {
        sql: ${campaign_name} LIKE '%-App-%';;
        label: "App"
      }
      when: {
        sql: ${campaign_name} LIKE '%-Youtube-%';;
        label: "Youtube"
      }
      when: {
        sql: ${campaign_name} LIKE '%-Installs-%';;
        label: "Installs"
      }

      else: "Others"
    }
  }

  dimension: randomized_campaign_name {
    type: string
    sql: REGEXP_REPLACE(${TABLE}.name, r'\b[Tt]heo\b|\b[Tt]heobroma\b', 'Demo') ;;
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

  measure: total_ad_spend {
    label: "Google Ad Spends"
    type: sum
    sql: ${TABLE}.cost_micros / 1000000 ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: revenue {
    type: sum_distinct
    sql: ${ga4_transaction_revenue.revenue_dim} ;;
    sql_distinct_key: ${ga4_transaction_revenue.__hevo_id}  ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
    filters: [ga4_transaction_revenue.source_medium: "google / cpc"]
  }

  measure: transactions {
    type: sum_distinct
    sql: ${ga4_transaction_revenue.transaction_dim} ;;
    sql_distinct_key: ${ga4_transaction_revenue.__hevo_id}  ;;
    value_format: "#,##0"
    filters: [ga4_transaction_revenue.source_medium: "google / cpc"]
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
