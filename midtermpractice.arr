use context dcic2024
fun km-to-miles(km :: Number) -> Number:
  doc: "converts kilometes to miles by dividing by 1.6"
  km / 1.6
where:
  km-to-miles(100) is 62.5
  km-to-miles(250) is 156.25
end

fun aqi-categories(aqi :: Number) -> String:
  doc: "Returns categories based on air quality index"
  if aqi <= 50:
    "Good"
  else if aqi <= 100:
    "Moderate"
  else if aqi <= 150:
    "Unhealthy"
    else:
    "Hazardous"
  end
    where: 
  aqi-categories(100) is "Moderate"
  end

basket = table: item :: String, price :: Number, quantity :: Number
  row: "apple", 0.50, 10
  row: "orange", 0.75, 5
  row: "watermelon", 2.99, 2
end
basket

fun calc-total(r :: Row) -> Number:
  r["quantity"] * r["price"]
end
basket-with-total = build-column(basket, "total", calc-total)

order-by(basket-with-total,"total",false)
