use context dcic2024
items= table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

items

#use transform-column function to change the values inside a column
# function to subtract -1 from the column
fun subtract-1(n :: Number) -> Number:
  doc: "subtracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

moved-items = transform-column(items, "x-coordinate", subtract-1)
moved-items

fun calc-distance(r :: Row) -> Number:
  doc: "calculates distance from origin by using x and y coordinates"
  num-sqrt(
    num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]))
  where:
  calc-distance(items.row-n(0)) is-roughly
    num-sqrt(num-sqr(23) + num-sqr(-87))
      
  calc-distance(items.row-n(3)) is-roughly
    num-sqrt(num-sqr(-9) + num-sqr(64))
end
    
items-with-dist = build-column(items, "distance", calc-distance)
items-with-dist

# task 1
fun pull-closer(n :: Number) -> Number:
  doc: "multiplies coordinates by 0.9 to pull 10% closer to origin"
  n * 0.9
where:
  pull-closer(10) is 9
  pull-closer(-20) is -18
  pull-closer(0) is 0
end

#apply transformation to both x and y coordinates
items-pulled-colser = transform-column(transform-column(items, "x-coordinate", pull-closer), "y-coordinate", pull-closer)

items-pulled-colser

fun calc-distance-squared(r :: Row) -> Number:
  doc: "calculates distance from origin by using x and y coordinates"
    num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"])
end
items-with-dist-sqr = build-column(items, "distance", calc-distance-squared)
items-with-dist-sqr

order-by(items-with-dist-sqr, "distance", true).row-n(0)["item"]

fun obfuscate(r :: Number) -> String:
  doc: "replaces displayed item with string of Xs"
  a = string-length(r["item"])
  string-repeat("X", n)
where:
  obfuscate(items.row-n(0)) is "XXXXXXXXXXXXX"
end

obfuscate-items = transform-column(items, "item", obfuscate)
obfuscate-items