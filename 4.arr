use context starter2024
fun add-two-numbers(first-num, second-num):
  #   computation
  first-num + second-num
end
add-two-numbers(10, 15)

fun welcome(name :: String) -> String:
  "Welcome to class, " + name
end
welcome("Evan")

fun area(width :: Number, height :: Number) -> Number:
  doc: "Finds area by multiplying width and height"
  width * height
end

check:
  area(3, 20) is 3 * 20
  area(4, 50) is 4 * 50
end

shrirt-price = 5
character-price = 0.1
fun tshirt-cost(num-shirts :: Number, string :: String) -> Number:
  doc: "Calculates price of tshirt based on number of shirts and number of characters"
  num-shirts * (shrirt-price + (string-length(string) * character-price))
end
tshirt-cost(4, "Go Team!")
tshirt-cost(7, "Hello World")  

fun celsius-to-fahrenheit(celcius :: Number) -> Number:
  doc: "Converts celcius to fahrenheit"
  (celcius * (9/5)) + 32
end

fun fahrenheit-to-celsius(fahrenheit :: Number) -> Number:
  doc: "Converts fahrenheit to celcius"
  (fahrenheit - 32) * (5/9)
end

check:
  celsius-to-fahrenheit(0) is 32
  fahrenheit-to-celsius(32) is 0
  celsius-to-fahrenheit(10) is 50
  fahrenheit-to-celsius(50) is 10
end
  
flag-len = 100
flag-width = 60
opacity = "solid"
flag = rectangle(flag-len, flag-width, opacity, "light blue")

stripe-width = 15

stripe = rectangle(flag-len, stripe-width, opacity, "yellow")

stars = star-polygon(10, 5, 2, opacity, "red")

overlay-xy(stars, -40, -20, (overlay-align("center", "center", stripe, flag)))


fun star-stripe-flag(top :: String, mid :: String, bot :: String) -> Image:
  doc: "Creates a flag with a stripe and star in the middle"
  frame(
    overlay-xy(star-polygon(10, 5, 2, opacity, top),-40, -20,
      (overlay-align("center", "center", rectangle(flag-len, stripe-width, opacity, mid),
          rectangle(flag-len, flag-width, opacity, bot)))))
end

star-stripe-flag("red", "yellow", "light blue")
star-stripe-flag("green", "white", "yellow")