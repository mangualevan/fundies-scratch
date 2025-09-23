use context starter2024
fun choose-hat(temp-in-C :: Number) -> String:
  doc: "Determines the appropriate head gear, with above 27C a sun hat, below 10 a winter hat, in between nothing"
  
  if temp-in-C > 27:
    "Wear sun hat while going out today"
  else if temp-in-C < 10:
    "Wear a winter hat while going out today"
  else:
    "The weather is good, no hat today"
  end #ends if condition
  
end #ends function


fun choose-hat2(temp-in-C :: Number) -> String:
  doc: "Determines the appropriate head gear, with above 27C a sun hat, below 10 a winter hat, in between nothing"
  
  ask:
    | temp-in-C > 27 then:
    "Wear sun hat while going out today"
    | temp-in-C < 10 then:
    "Wear a winter hat while going out today"
    | otherwise:
      "The weather is good, no hat today"
  end #ends if condition
  
end #ends function

fun add-glasses(outfit :: String) -> String:
  outfit + ", and glasses"
end

fun choose-outfit(temp-in-C :: Number) -> String:
  add-glasses(choose-hat(temp-in-C))
end

fun choose-hat-or-visor(temp-in-C :: Number, has-visor :: Boolean) -> String:
  if (has-visor == true) and (temp-in-C > 30):
    add-glasses("It is very hot, wear a visor")
  else if (has-visor == true) and (temp-in-C < 30): 
    add-glasses("You do not need a visor today, wear a hat")
  else: 
    add-glasses("You dont have a visor, wear a hat")
  end
end

choose-hat-or-visor(31, false)
choose-hat-or-visor(31, true)
choose-hat-or-visor(30, true)

