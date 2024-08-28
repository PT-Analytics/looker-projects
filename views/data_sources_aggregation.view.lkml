view: data_sources_aggregation {
  extension: required


  measure: ad_spends {
    label: "Total Ad Spends All Platforms"
    view_label: "Google + Facebook + Bing"
    type: number
    sql:${google_ads.total_ad_spend}+${meta_ads.total_ad_spend};;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
    html: @{currency}{{rendered_value}};;
  }


  measure: total_impressions {
    label: "Total Ad Impressions"
    view_label: "Google + Facebook + Bing"
    type: number
    sql:${meta_ads.impressions}+${google_ads.impressions};;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }

  measure: total_clicks {
    label: "Total Ad Impressions"
    view_label: "Google + Facebook + Bing"
    type: number
    sql:${meta_ads.clicks}+${google_ads.clicks};;
    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\""
  }



}
