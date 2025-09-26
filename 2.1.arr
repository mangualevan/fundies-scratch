use context starter2024
# Creates an orange triangle
orange-triangle = triangle(35, "solid", "orange")
#Displays triangle
orange-triangle

side = 30
color = "green"
green-square = square(side, "solid", color)
green-square

green-square-2 = square(30, "solid", "green")
green-square-2

# Declaration conflicts with previous declaration
# side = 40
# green-square


yellow-circle = circle(10, "solid", "yellow")
black-rectangle = rectangle(40, 60, "solid", "black")

radius = 10
circle-color = "yellow"
yellow-circle-2 = circle(radius, "solid", circle-color)

overlay(yellow-circle, black-rectangle)
overlay(yellow-circle-2, black-rectangle)

side-by-side = beside(yellow-circle, yellow-circle-2)
overlay-align("center", "center", side-by-side, black-rectangle)

flag-len = 100
flag-width = 60
flag-color = "light blue"
opacity = "solid"
flag = rectangle(flag-len, flag-width, opacity, flag-color)

stripe-width = 15
stripe-color = "yellow"
stripe = rectangle(flag-len, stripe-width, opacity, stripe-color)

star-color = "red"
stars = star-polygon(10, 5, 2, opacity, star-color)

overlay-xy(stars, -40, -20, (overlay-align("center", "center", stripe, flag)))
