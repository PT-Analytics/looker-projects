connection: "bq-looker-service-acc"

# Include all views in the views folder
include: "/views/**/*.view.lkml"

# Optional: Define a datagroup for caching policy (if needed)
datagroup: theobroma_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: theobroma_default_datagroup

# ----------------------------
# Explores
# ----------------------------

explore: anomaly_detection_theobroma_impressions {
  from : vw_anomaly_detection_theobroma_impressions
}

explore: anomaly_detection_theobroma_clicks {
  view_name: vw_anomaly_detection_theobroma_clicks
}

explore: anomaly_detection_theobroma_ctr {
  view_name: vw_anomaly_detection_theobroma_ctr
}

explore: anomaly_detection_theobroma_cost {
  view_name: vw_anomaly_detection_theobroma_cost
}

# You can add joins here if needed
# Example:
# explore: anomaly_detection_theobroma_clicks {
#   join: anomaly_detection_theobroma_impressions {
#     relationship: many_to_one
#     sql_on: ${anomaly_detection_theobroma_impressions.primary_key} = ${anomaly_detection_theobroma_clicks.primary_key} ;;
#   }
# }
