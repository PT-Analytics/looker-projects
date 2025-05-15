
connection: "bq-looker-service-acc"

include: "/views/*.view.lkml"

datagroup: theobroma_datagroup {
  max_cache_age: "24 hour"
}

persist_with: theobroma_datagroup


explore: vw_conv_summary {
  view_label: "Theobroma Conversation Model"
  label: "Theobroma Conversation Model"
}
