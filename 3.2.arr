use context dcic2024
# workouts = table: date :: String, activity :: String, duration :: Number
#   row: "2025-04-01", "Running", 30
#   row: "2025-04-02", "Yoga", 45
#   row: "2025-04-03", "Cycling", 60
# end

# workouts

# check:
#   table: date :: String, activity :: String, duration :: Number
#     row: "2025-04-01", "Running", 30
#     row: "2025-04-02", "Yoga", 45
#     row: "2025-04-03", "Cycling", 60
#   end
#   is-not
#   table: date :: String, activity :: String, duration :: Number
#     row: "2025-04-03", "Cycling", 60
#     row: "2025-04-01", "Running", 30
#     row: "2025-04-02", "Yoga", 45
#   end
# end

# second-workout = workouts.row-n(1)
# second-workout
# second-workout["activity"]  # -> "Yoga"
# # or all at once:
# workouts.row-n(1)["duration"]  # -> 45

include csv
include data-source
plants= load-table:
  plant_common_name :: String,
  location_latitude :: String,
  location_longitude :: String,
  date_sighted :: String,
  soil_type :: String,
  plant_height_cm :: String,
  plant_color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end

# plants
# plants.length()

# plants.row-n(100)
# row-n-too-large

glucose = load-table:
  patient_id :: String,
  glucose_level :: String,
  date_time :: String,
  insulin_dose :: String,
  exercise_duration :: String,
  stress_level :: String
  source: csv-table-file("glucose-levels.csv", default-options)
  sanitize patient_id using num-sanitizer
  sanitize glucose_level using num-sanitizer
  sanitize insulin_dose using num-sanitizer
  sanitize exercise_duration using num-sanitizer
  sanitize stress_level using num-sanitizer
end

glucose