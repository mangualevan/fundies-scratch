use context dcic2024
# Exercise 1
include csv
include data-source

flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  
  source: csv-table-file("flights.csv", default-options)
    
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
    sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

flights

fun is_long_flight(r :: Row) -> Boolean:
  doc: "Checks if a rows distance is greater than 1500"
  r["distance"] >= 1500
where:
  is_long_flight(flights.row-n(0)) is false
  is_long_flight(flights.row-n(3)) is true
end

long_flights = filter-with(flights, is_long_flight)

long_flights

air_time_sort = order-by(flights, "air_time", false)
air_time_sort

first-row = air_time_sort.row-n(0)

first-row["carrier"]
first-row["origin"]
first-row["dest"]

# Exercise 2
fun is_delayed_departure(r :: Row) -> Boolean:
  doc: "Checks if a rows delay is greater than 30"
  r["dep_delay"] >= 30
where:
  is_delayed_departure(flights.row-n(0)) is false
  is_delayed_departure(flights.row-n(55)) is true
end

fun is_morning_sched_dep(r :: Row) -> Boolean:
  doc: "Checks if a rows departure is before 1200"
  r["sched_dep_time"] < 1200
where:
  is_morning_sched_dep(flights.row-n(0)) is true
  is_morning_sched_dep(flights.row-n(309)) is false
end

delay_filter = filter-with(flights, lam(r): r["dep_delay"] >= 30 end)


morning_delay_filter = filter-with(delay_filter, lam(r): r["sched_dep_time"] < 1200 end)

morning_delay_dist_filter = filter-with(morning_delay_filter, lam(r): r["distance"] > 500 end)

morning_delay_dist_filter

dep_delay_sort = order-by(delay_filter, "dep_delay", false)
dep_delay_sort

most_delayed_row = dep_delay_sort.row-n(0)

most_delayed_row["flight"]
most_delayed_row["origin"]
most_delayed_row["dep_delay"]

# Exercise 3
no_neg_delay = transform-column(
  transform-column(flights, "dep_delay", lam(x): if x < 0: 0 else: x end end),
  "arr_delay",
  lam(x): if x < 0: 0 else: x end end)

flights_with_speed = build-column(flights, "effective_speed", lam(n): if n["air_time"] > 0: n["distance"] / (n["air_time"] / 60) 
  else: 0 end end)

sort_by_speed = order-by(flights_with_speed, "effective_speed", false)

fastest_flight = sort_by_speed.row-n(0)

fastest_flight["carrier"]
fastest_flight["origin"]
fastest_flight["dest"]

# Exercise 4
fun apply-arrival-discount(t :: Table) -> Table:
  doc: "Takes a table t and reduces arr_delay by 20% when arr_delay is from 0 to 45"
  transform-column(
    t,
    "arr_delay",
    lam(x):
      if (x >= 0) and (x <= 45):
        x * 0.8
      else:
        x
      end
    end)
where:
  test-table = table: arr_delay
    row: -10 
    row: 0 
    row: 30
    row: 60
  end
  
  apply-arrival-discount(test-table) is table: arr_delay
    row: -10    
    row: 0       
    row: 24      
    row: 60     
  end
end

# Apply to flights table
apply-arrival-discount(flights)

flights_with_score = build-column(flights, "on_time_score", lam(x): 
    d = if x["dep_delay"] > 0: x["dep_delay"] else: 0 end
    a = if x["arr_delay"] > 0: x["arr_delay"] else: 0 end
  score = 100 - (d - a) - (a / 30)
if score > 0: score else: 0 end 
end)

score_sort = order-by(order-by(flights_with_score, "distance", true), "on_time_score", false)

top1 = score_sort.row-n(0)
top2 = score_sort.row-n(1)

score_sort

top1["carrier"]
top1["flight"]
top1["origin"]
top1["dest"]

top2["carrier"]
top2["flight"]
top2["origin"]
top2["dest"]