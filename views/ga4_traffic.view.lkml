include: "/views/*.view.lkml"
view: ga4_traffic {

  sql_table_name: `puretech-edw.Theobroma.VW_Traffic` ;;

  extends: [data_sources_aggregation]

  dimension: __hevo_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.__hevo_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year,time,day_of_week]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.session_campaign_name ;;
  }

  dimension: session_default_channel_group {
    type: string
    sql: ${TABLE}.session_default_channel_group ;;
  }

  dimension: source_medium {
    type: string
    sql: ${TABLE}.session_source_medium ;;
  }


  measure: sessions {
    type: sum
    sql: ${TABLE}.sessions ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: total_users {
    type: sum
    sql: ${TABLE}.total_users ;;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  dimension: event_raw{
    sql:  ${date_time::datetime} ;;
    type: date_raw
    hidden: yes
  }

  dimension_group: in_period {
    type: duration
    intervals: [day]
    description: "Gives the number of days in the current period date range"
    sql_start: {% date_start current_date_range %} ;;
    sql_end: {% date_end current_date_range %} ;;
    hidden:  yes
  }

  dimension: period_2_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of the previous period"
    type: date_raw
    sql:
    {% if compare_to._in_query %}
      {% if compare_to._parameter_value == "Period" %}
        TIMESTAMP_SUB({% date_start current_date_range %} , INTERVAL ${days_in_period} DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME({% date_start current_date_range %}) , INTERVAL 1 {% parameter compare_to %}))
      {% endif %}
    {% else %}
      {% date_start previous_date_range %}
    {% endif %};;
    hidden:  yes
  }

  dimension: period_2_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of the previous period"
    type: date_raw
    sql:
    {% if compare_to._in_query %}
      {% if compare_to._parameter_value == "Period" %}
        TIMESTAMP_SUB({% date_start current_date_range %}, INTERVAL 1 DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end current_date_range %}), INTERVAL 1 DAY), INTERVAL 1 {% parameter compare_to %}))
      {% endif %}
    {% else %}
      {% date_end previous_date_range %}
    {% endif %};;
    hidden:  yes
  }

  dimension: period_3_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of 2 periods ago"
    type: date_raw
    sql:
    {% if compare_to._parameter_value == "Period" %}
      TIMESTAMP_SUB({% date_start current_date_range %}, INTERVAL 2*${days_in_period} DAY)
    {% else %}
      TIMESTAMP(DATETIME_SUB(DATETIME({% date_start current_date_range %}), INTERVAL 2 {% parameter compare_to %}))
    {% endif %};;
    hidden: yes

  }

  dimension: period_3_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of 2 periods ago"
    type: date_raw
    sql:
    {% if compare_to._parameter_value == "Period" %}
      TIMESTAMP_SUB(${period_2_start}, INTERVAL 1 DAY)
    {% else %}
      TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end current_date_range %}), INTERVAL 1 DAY), INTERVAL 2 {% parameter compare_to %}))
    {% endif %};;
    hidden: yes
  }

  dimension: period_4_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of 4 periods ago"
    type: date_raw
    sql:
    {% if compare_to._parameter_value == "Period" %}
      TIMESTAMP_SUB({% date_start current_date_range %}, INTERVAL 3*${days_in_period} DAY)
    {% else %}
      TIMESTAMP(DATETIME_SUB(DATETIME({% date_start current_date_range %}), INTERVAL 3 {% parameter compare_to %}))
    {% endif %};;
    hidden: yes
  }

  dimension: period_4_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of 4 periods ago"
    type: date_raw
    sql:
      {% if compare_to._parameter_value == "Period" %}
        TIMESTAMP_SUB(${period_2_start}, INTERVAL 1 DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end current_date_range %}), INTERVAL 1 DAY), INTERVAL 3 {% parameter compare_to %}))
      {% endif %};;
    hidden: yes
  }

  dimension: period {
    view_label: "Timeline Comparison Fields"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    order_by_field: order_for_period
    sql:
       {% if current_date_range._is_filtered %}
         CASE
           WHEN {% condition current_date_range %}  ${event_raw} {% endcondition %}
           THEN "This {% parameter compare_to %}"
           WHEN ${event_raw} between ${period_2_start} and ${period_2_end}
           THEN "Last {% parameter compare_to %}"
           WHEN ${event_raw} between ${period_3_start} and ${period_3_end}
           THEN "2 {% parameter compare_to %}s Ago"
           WHEN ${event_raw} between ${period_4_start} and ${period_4_end}
           THEN "3 {% parameter compare_to %}s Ago"
         END
       {% else %}
         NULL
       {% endif %}
       ;;
  }

  dimension: order_for_period {
    hidden: yes
    view_label: "Timeline Comparison Fields"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    skip_drill_filter: yes
    sql:
       {% if current_date_range._is_filtered %}
         CASE
           WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
           THEN 1
           WHEN ${event_raw} between ${period_2_start} and ${period_2_end}
           THEN 2
           WHEN ${event_raw} between ${period_3_start} and ${period_3_end}
           THEN 3
           WHEN ${event_raw} between ${period_4_start} and ${period_4_end}
           THEN 4
         END
       {% else %}
         NULL
       {% endif %}
       ;;
  }

  dimension_group: date_in_period {
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMP_ADD({% date_start current_date_range %},INTERVAL (${day_in_period}-1) DAY) ;;
    view_label: "Timeline Comparison Fields"
    timeframes: [date, week, month, quarter, year]
  }

  dimension: day_in_period {
    view_label: "Timeline Comparison Fields"
    description: "Gives the number of days since the start of each periods. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
    {% if current_date_range._is_filtered %}
      CASE
        WHEN {% condition current_date_range %} ${event_raw} {% endcondition %}
        THEN TIMESTAMP_DIFF(${event_raw},{% date_start current_date_range %},DAY)+1

      WHEN ${event_raw} between ${period_2_start} and ${period_2_end}
      THEN TIMESTAMP_DIFF(${event_raw}, ${period_2_start},DAY)+1

      WHEN ${event_raw} between ${period_3_start} and ${period_3_end}
      THEN TIMESTAMP_DIFF(${event_raw}, ${period_3_start},DAY)+1

      WHEN ${event_raw} between ${period_4_start} and ${period_4_end}
      THEN TIMESTAMP_DIFF(${event_raw}, ${period_4_start},DAY)+1
      END

      {% else %} NULL
      {% endif %}
      ;;
    hidden: yes
  }

  parameter: compare_to {
    description: "Choose the period you would like to compare to. Must be used with Current Date Range filter"
    label: "2a. Compare To (Templated):"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
    view_label: "Timeline Comparison Fields"
  }

  parameter: comparison_periods {
    label: "3. Number of Periods"
    description: "Choose the number of periods you would like to compare - defaults to 2. Only works with templated periods from step 2."
    type: unquoted
    allowed_value: {
      label: "2"
      value: "2"
    }
    allowed_value: {
      label: "3"
      value: "3"
    }
    allowed_value: {
      label: "4"
      value: "4"
    }
    default_value: "2"
    view_label: "Timeline Comparison Fields"
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Daily"
      value: "day"
    }
    allowed_value: {
      label: "Weekly"
      value: "week"
    }
    allowed_value: {
      label: "Monthly"
      value: "month"
    }
  }

  filter: current_date_range {
    view_label: "Timeline Comparison Fields"
    label: "1. Date Range"
    description: "Select the date range you are interested in using this filter, can be used by itself. Make sure any filter on Event Date covers this period, or is removed."
    type: date
    datatype: date
    convert_tz: yes
  }
  filter: previous_date_range {
    view_label: "Timeline Comparison Fields"
    label: "2b. Compare To (Custom):"
    group_label: "Compare to:"

    description: "Use this if you want to specify a custom date range to compare to (limited to 2 comparison periods). Always use with '1. Date Range' filter (or it will error). Make sure any filter on Event Date covers this period, or is removed."

    type: date
    datatype: date
    convert_tz: yes
  }

}
