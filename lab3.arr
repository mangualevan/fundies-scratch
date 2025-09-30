use context dcic2024
include csv
include data-source
# Problem 1
fun is-leap-year(year :: Number) -> Boolean:
  doc: "Determines if the given year is a leap year"
  if num-modulo(year, 4) == 0:
    true
  else:
    false
  end
  where:
    is-leap-year(2024) is true
    is-leap-year(2025) is false
  end 

# Problem 2
fun tick(seconds :: Number) -> Number:
  doc: "Returns the second after the given second"
  if seconds <= 58:
    seconds + 1
  else:
    0
  end
where:
  tick(1) is 2
  tick(58) is 59
  tick(59) is 0
end

# Problem 3
fun rock-paper-scissors(player1 :: String, player2 :: String) -> String:
  doc: "Returns winner or tie of a game of rock, paper, scissors"
  if ((player1 == "rock") and (player2 == "scissors")) or ((player1 == "scissors") and (player2 == "paper")) or ((player1 == "paper") and (player2 == "rock")):
    "player1"
  else if ((player2 == "rock") and (player1 == "scissors")) or ((player2 == "scissors") and (player1 == "paper")) or ((player2 == "paper") and (player1 == "rock")):
    "player2"
  else if player1 == player2:
    "tie"
  else:
    "invalid choice"
  end
where:
  rock-paper-scissors("rock","paper") is "player2"
  rock-paper-scissors("paper","rock") is "player1"
  rock-paper-scissors("rock","rock") is "tie"
  rock-paper-scissors("paper","fire") is "invalid choice"
end

  # Problem 4
planets = table: Planet :: String, Distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end
mars = planets.row-n(3)
mars
mars["Distance"]

# Problem 5
something = load-table:
  year :: String,
  day :: String,
  month :: String,
  rate :: String
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end

something
something.length()
median(something, "rate")
modes(something, "rate")
order-by(something, "rate", true)
min-rate = 0.1
order-by(something, "rate", false)
max-rate = 17
