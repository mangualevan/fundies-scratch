use context dcic2024
#| Task Plan
   Load table from flights_sample53.csv
   
   Sanitize numbers and sanitize flight column with string-sanitizer
   
   Use transform column with a lambda that replaces empty strings with UNKNOWN in tailnum column
   
   Replace negative values in dep_delay and arr_delay by using transform column with lambda that replaces negative numbers with 0
   
   Problem: The carrier column has inconsistent formatting (extra spaces, lowercase letters).
   
Planned Step: "Clean the carrier column by trimming spaces and converting text to uppercase."

Implementation: Use transform-column with a lambda that applies trim and string-to-upper to each value. 

 Normalise departure times in dep_time to "HH:MM" format by dividing dep_time by 100 and converting that number into a string
   
   Create dedup_key column using build column
|#

include csv
include data-source

flights_53 = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: String,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  
  source: csv-table-file("flights_sample53.csv", default-options)
    
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using string-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

flights_53


unknown-tailnum = transform-column(flights_53, "tailnum", lam(s): if s == "": "UNKNOWN"
    else: s
  end end)

unknown-tailnum

no-neg-delay = transform-column(
  transform-column(unknown-tailnum, "dep_delay", lam(x): if x < 0: 0 else: x end end),
  "arr_delay",
  lam(x): if x < 0: 0 else: x end end)

no-neg-delay

# Trim spaces at both ends
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
end

trimmed = transform-column(no-neg-delay, "carrier", trim)

trimmed-upper-carrier = transform-column(trimmed, "carrier", lam(s): string-to-upper(s) end)

trimmed-upper-carrier

normalise-dep-time = transform-column(trimmed-upper-carrier, "dep_time", lam(n): 
    s = num-to-string(n)
    if (n / 100.00) < 10.00 :
      
      "0" + string-substring(s,0,1) + ":" + string-substring(s,1,3)
    else:
      string-substring(s,0,2) + ":" + string-substring(s,2,4)
  end end)

normalise-dep-time

dedup-key = build-column(normalise-dep-time, "dedup_key", lam(s): s["flight"] + "-" + s["carrier"] + "-" + s["dep_time"] end)

dedup-key

airline = build column(dedup-key, "airline", lam(s):
    if s["carrier"] == "UA":
      "United Airlines"
      else if:
      s["carrier"] == "AA":
      "American Airlines"
      else if:
      s["carrier"] == "B6":
      "JetBlue"
      else if:
      s["carrier"] == "DL":
      "Delta Air Lines"
      else if:
      s["carrier"] == "EV":
      "ExpressJet"
      else if:
      s["carrier"] == "WN":
      "Southwest Airlines"
      else if:
      s["carrier"] == "OO":
      "SkyWest Airlines"
      else:
      "Other"
  end end)