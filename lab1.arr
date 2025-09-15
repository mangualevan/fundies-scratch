use context starter2024
fun cost(shirts):
  (12 * shirts) + 3
end
    cost(5)
    cost(7)

w = 420
h = 592 
perimeter = 2 * (w + h)
price = perimeter * 0.10
price
# When you get rid of the parenthesis an error occurs because the order of operations is not clear

"Designs for everyone!"
"red"
"blue"
"gold"

"red" + "blue"
# 1 + "blue"

overlay-align("center","center",below(circle(15,"solid","green"),((above(circle(15,"solid","red"),circle(15,"solid", "yellow"))))), rectangle(40, 100, "solid", "black"))

# Goal: A rectangle with width 50 and height 20, solid black
#rectangle(50, "solid", 20, "black")
#Arguments are in the wrong order. Length and width are first
rectangle(50, 20, "solid", "black")

# circle(30, solid, "red")
#Missing parenthesis
circle(30, "solid", "red")

overlay-xy(rectangle(100, 15, "solid", "yellow"), 0, -30, (overlay-align("center","top", star-polygon(15, 5 , 2, "solid", "red"),rectangle(100, 60, "solid", "light blue"))))

overlay-align("center","center",star-polygon(30, 5 , 2, "solid", "green"), rotate(45, square(100, "solid", "gray")))




