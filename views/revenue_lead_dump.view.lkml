
view: revenue_lead_dump {

 sql_table_name: `puretech-edw.Theobroma.theobroma___lead_dump___new_format_sheet1` ;;

  dimension: __hevo_id {
    type: number
    description: "{\"pk_p\":\"0\"}"
    sql: ${TABLE}.__hevo_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: operating_system {
    type: string
    case: {
      when: {
        sql: ${os} = 'I' ;;
        label: "IOS"
      }
      when: {
        sql: ${os} = 'A' ;;
        label: "Android"
      }
      when: {
        sql: ${os} = 'website' ;;
        label: "Website"
      }

      else: "Others"
    }
  }

  dimension_group: date {
    type: time
    description: "{\"dl\":\"28\"}"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.invoice_at ;;
  }

  # dimension: orderid {
  #   type: number
  #   description: "{\"dl\":\"11\"}"
  #   value_format_name: id
  #   sql: ${TABLE}.orderid ;;
  # }

  # dimension: subtotal {
  #   type: number
  #   description: "{\"dl\":\"6\"}"
  #   sql: ${TABLE}.subtotal ;;
  # }

  # dimension: taxes {
  #   type: number
  #   description: "{\"dl\":\"11\"}"
  #   sql: ${TABLE}.taxes ;;
  # }

  # dimension: wallet_amount {
  #   type: number
  #   description: "{\"dl\":\"3\"}"
  #   sql: ${TABLE}.wallet_amount ;;
  # }

  measure: total_amount {
    type: sum
    sql: ${TABLE}.total ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

  measure: discount_amount {
    type: sum
    sql: ${TABLE}.discount ;;
    html: @{currency}{{rendered_value}} ;;
    value_format: "#,##0"
  }

}
