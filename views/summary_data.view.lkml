# The name of this view in Looker is "Vw Summary Data"
view: vw_summary_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `puretech-edw.Theobroma.VW_SummaryData` ;;


  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year,month_name,month_num]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: week_group {
    type: string
    sql:
    CONCAT(
      'Week ',
      CAST(
        LEAST(
          DIV(DATE_DIFF(${date_date}, DATE_TRUNC(${date_date}, MONTH), DAY), 7) + 1,
          5
        ) AS STRING
      )
    ) ;;
  }


  dimension: month_year {
    type: string
    sql: CONCAT(${date_month_name},'-',${date_year}) ;;
  }

  dimension: month_sorting_order {
    type: number
    sql: ${date_year} * 100 + CASE
        WHEN ${date_month_name} = 'January' THEN 1
        WHEN ${date_month_name} = 'February' THEN 2
        WHEN ${date_month_name} = 'March' THEN 3
        WHEN ${date_month_name} = 'April' THEN 4
        WHEN ${date_month_name} = 'May' THEN 5
        WHEN ${date_month_name} = 'June' THEN 6
        WHEN ${date_month_name} = 'July' THEN 7
        WHEN ${date_month_name} = 'August' THEN 8
        WHEN ${date_month_name} = 'September' THEN 9
        WHEN ${date_month_name} = 'October' THEN 10
        WHEN ${date_month_name} = 'November' THEN 11
        WHEN ${date_month_name} = 'December' THEN 12
    END ;;
    hidden: yes
  }

  dimension: unique_key {
    type: string
    sql: ${TABLE}.unique_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: spends {
    type: sum
    sql: ${TABLE}.spends ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: transactions {
    type: sum
    sql: ${TABLE}.transac ;;
    value_format: "#,##0"
  }

  measure: cost_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${spends},${transactions});;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: roas {
    type: number
    sql: SAFE_DIVIDE(${revenue},${spends});;
    value_format: "0%"
  }

  measure: aov {
    type: number
    sql: SAFE_DIVIDE(${revenue},${transactions});;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  # measure: backend_revenue {
  #   type: sum
  #   sql: ${TABLE}.total_amount;;
  #   html: @{currency}{{rendered_value}} ;;
  #   value_format: "#,##0"
  # }

  measure: app_revenue {
    type: sum
    sql: ${TABLE}.total_app_revenue;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: ios_revenue {
    type: sum
    sql: ${TABLE}.ios_revenue;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: android_revenue {
    type: sum
    sql: ${TABLE}.android_revenue;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: blended_roas {
    type: number
    sql: SAFE_DIVIDE(${backend_revenue_ex_ondc},${spends});;
    value_format: "0%"
  }

  measure: backend_revenue_with_ondc {
    type: sum
    sql: ${TABLE}.backend_revenue_with_ondc;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: backend_revenue_ex_ondc {
    type: sum
    sql: ${TABLE}.backend_revenue_ex_ondc;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.net_revenue;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: backend_web_revenue {
    type: sum
    sql: ${TABLE}.backend_web_revenue;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: ga4_cpc_revenue {
    type: sum
    sql: ${TABLE}.ga4_cpc_revenue;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: ondc_revenue {
    type: number
    sql: ${backend_revenue_with_ondc} - ${backend_revenue_ex_ondc};;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }
}
