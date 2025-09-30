use context dcic2024
include csv
include data-source

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end
orders

high-value-orders = table: time, amount
  row: "08:00", 10.50
  row: "10:15", 8.00
end

fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.00
where:
  is-high-value(orders.row-n(2)) is true
  is-high-value(orders.row-n(3)) is false
end

new-high-orders = filter-with(orders, is-high-value)
new-high-orders

check:
  new-high-orders is high-value-orders
end

fun is-morning(o :: Row) -> Boolean:
  o["time"] < "12:00"
where:
  is-morning(orders.row-n(0)) is true
  is-morning(orders.row-n(5)) is false
end

morning-orders = filter-with(orders, is-morning)

morning-orders2 = filter-with(orders, lam(o): o["time"] < "12:00" end)

sorted = order-by(orders, "time", false)

last-row = sorted.row-n(0)
last-row["amount"]

photos= load-table:
  Location :: String,
  Subject :: String,
  Date :: String
  source: csv-table-url("https://pdi.run/f25-2000-photos.csv", default-options)
end

is-forest = filter-with(photos, lam(o): o["Subject"] == "Forest" end)

sorted-forest = order-by(is-forest, "Date", false)

first-row = sorted-forest.row-n(0)
first-row["Location"]

location-counts = count(photos, "Location")

order-by(location-counts, "count", false)

freq-bar-chart(photos, "Location")