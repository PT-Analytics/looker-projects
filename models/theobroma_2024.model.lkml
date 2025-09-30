connection: "bq-looker-service-acc"

include: "/views/*.view.lkml"

datagroup: theobroma_datagroup {
  max_cache_age: "24 hour"
}

persist_with: theobroma_datagroup

explore: vw_theobroma_monetization {
  view_label: "Theobroma Monetization"
  label: "Theobroma Monetization"
}
explore: theobrama_ga4_channelwise {
  label: "Theobroma GA4 - Channelwise"
  view_label: "Theobrama Channelwise"
}

explore: theobrama_ga4_device {
  label: "Theobroma GA4 - Device"
  view_label: "Theobrama Device"
}

explore: theobrama_ga4_landingpage {
  label: "Theobroma GA4 - Landing Page"
  view_label: "Theobrama Landing Page"
}

explore: theobrama_ga4_traffic {
  label: "Theobroma GA4 - Traffic"
  view_label: "Theobrama Traffic"
}


explore: ga4_traffic {
  view_label: "Theobroma Data Model"
  label: "Theobroma Data Model"

  sql_always_where:

  {% if ga4_traffic.current_date_range._is_filtered %}
  {% condition ga4_traffic.current_date_range %} ${event_raw} {% endcondition %}

    {% if ga4_traffic.previous_date_range._is_filtered or ga4_traffic.compare_to._in_query %}
    {% if ga4_traffic.comparison_periods._parameter_value == "2" %}
    or
    ${event_raw} between ${period_2_start} and ${period_2_end}

    {% elsif ga4_traffic.comparison_periods._parameter_value == "3" %}
    or
    ${event_raw} between ${period_2_start} and ${period_2_end}
    or
    ${event_raw} between ${period_3_start} and ${period_3_end}


    {% elsif ga4_traffic.comparison_periods._parameter_value == "4" %}
    or
    ${event_raw} between ${period_2_start} and ${period_2_end}
    or
    ${event_raw} between ${period_3_start} and ${period_3_end}
    or
    ${event_raw} between ${period_4_start} and ${period_4_end}

    {% else %} 1 = 1
    {% endif %}
    {% endif %}
    {% else %} 1 = 1
    {% endif %}
    ;;

  join: ga4_transaction_revenue{
    view_label: "Traffic + ECommerce"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${ga4_transaction_revenue.date_date} and
      ${ga4_traffic.campaign_name} = ${ga4_transaction_revenue.campaign_name};;
  }

  join: google_ads {
    view_label: "Google Ads + Traffic"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.campaign_name} = ${google_ads.campaign_name} and
      ${ga4_traffic.date_date} = ${google_ads.date_date};;
  }

  join: meta_ads {
    view_label: "Meta Ads + Traffic"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${meta_ads.date_date} and
      ${ga4_traffic.campaign_name} = ${meta_ads.campaign_name};;
  }

  join: bing_ads {
    view_label: "Bing Ads + Traffic"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${bing_ads.date_date} and
      ${ga4_traffic.campaign_name} = ${bing_ads.campaign_name};;
  }


  join: firebase_revenue {
    view_label: "Firebase Revenue"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${firebase_revenue.date_date};;
  }

  join: vw_summary_data {
    view_label: "Summary Sheet"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${vw_summary_data.date_date} ;;
  }

  join: item_revenue {
    view_label: "Item Revenue + Traffic"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${item_revenue.date_date} ;;
  }

  join: ecom_funnel {
    view_label: "Ecomm Funnel + Traffic"
    relationship: many_to_many
    type: full_outer
    sql_on: ${ga4_traffic.date_date} = ${ecom_funnel.date_date} ;;
  }

  join: vw_os {
    view_label: "Operating System Data"
    relationship: many_to_many
    type: full_outer
    sql_on: ${vw_os.date_date} = ${ga4_traffic.date_date} ;;
  }

  join: app_daily {
    view_label: "App Data"
    relationship: many_to_many
    type: full_outer
    sql_on: ${app_daily.date_date} = ${ga4_traffic.date_date} ;;
  }

  join: revenue_lead_dump {
    view_label: "Revenue Dump"
    relationship: many_to_many
    type: full_outer
    sql_on: ${revenue_lead_dump.date_date} = ${ga4_traffic.date_date} ;;
  }


  join: platform_wise_spends_trans_revenue {
    view_label: "Channel Split"
    relationship: many_to_many
    type: full_outer
    sql_on: ${platform_wise_spends_trans_revenue.date_date} = ${ga4_traffic.date_date}  ;;
}

}
