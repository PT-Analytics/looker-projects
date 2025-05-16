
connection: "bq-looker-service-acc"

include: "/views/*.view.lkml"

datagroup: theobroma_datagroup {
  max_cache_age: "24 hour"
}

persist_with: theobroma_datagroup


explore: vw_conv_summary {
  view_label: "Theobroma Conversation Model"
  label: "Theobroma Conversation Model"

  join: item_revenue {
    view_label: "Item Revenue + Traffic"
    relationship: many_to_many
    type: full_outer
    sql_on: ${vw_conv_summary.date_date} = ${item_revenue.date_date} ;;
  }

  # join: ga4_traffic {
  #   view_label: "Summary + Traffic"
  #   relationship: many_to_many
  #   type: full_outer
  #   sql_on: ${vw_conv_summary.date_date} = ${ga4_traffic.date_date} ;;
  # }
}
