use context dcic2024
# import following two libraries
# math
import math as M
# statistics
import statistics as S
# lists
import lists as L

cafe-data =
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

sales = cafe-data.get-column("drinks-sold")

sample-list = [list: 4,5,3,2,6,7]
sample-list

empty-list = [list:]
empty-list

# perform following computations
# max
M.max(sales)
# min
M.min(sales)
# mean
S.mean(sales)
# sum
M.sum(sales)

# multiply all numbers together ;for example,  the output of [list: 2,3,4] is 24
fun product(lst :: List<Number>) -> Number block:
  doc: "multiplies all numbers in a list together"
  var result = 1
  for each(num from lst):
    result := num * result
  end
  result
where:
  product([list: 2,3,4]) is 24
  product([list: 6,5,2]) is 60
end

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

unique-codes = distinct(discount-codes)

upper-codes = map(string-to-upper, unique-codes)

upper-codes
# There are 5 unique codes after cleaning. There are two "NONE"codes because they originally had different cases

fixed-upper-codes = distinct(map(string-to-upper, discount-codes))
fixed-upper-codes

responses = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]

unique-lower-responses = distinct(map(string-to-lower, responses))
  
L.filter(lam(r): not(r == "maybe") end, unique-lower-responses)

fun sum-even-numbers(lst :: List<Number>) -> Number block:
  doc: "adds all even numbers in a list together"
  var result = 0
  for each(num from lst):
    if num-modulo(num, 2) == 0:
      result := num + result
    else:
      result
  end
  end
  result
where:
    sum-even-numbers([list: 2,3,4]) is 6
    sum-even-numbers([list: 6,5,2]) is 8
end

fun my-length(lst :: List<Number>) -> Number block:
  doc: "returns the number of elements in a list"
  var result = 0
  for each(num from lst):
    result := result + 1
  end
  result
where:
  my-length([list: 2,3,4,5]) is 4
  my-length([list:]) is 0
end

fun my-doubles(lst :: List<Number>) -> List<Number> block:
  doc: "doubles each number in a list"
  var doubled = [list:]
  for each(num from lst):
    doubled := doubled.append([list: num * 2])
  end
  doubled
where:
  my-doubles([list: 2,3,4,5]) is [list: 4,6,8,10]
  my-doubles([list:]) is [list:]
end

fun my-doubles-map(lst :: List<Number>) -> List<Number> block:
  doc: "doubles each number in a list"
  lst.map(lam(n): n * 2 end)
  where:
  my-doubles-map([list: 2,3,4,5]) is [list: 4,6,8,10]
  my-doubles-map([list:]) is [list:]
end

fun my-string-lens(lst :: List<String>) -> List<Number> block:
  doc: "returns new list where each element is the length of the string in the corresponding position of the input list"
  var string-len = [list:]
  for each(string from lst):
    string-len := string-len.append([list: string-length(string)])
  end
  string-len
where:
  my-string-lens([list: "hello", "world"]) is [list: 5,5]
  my-string-lens([list:""]) is [list:0]
end

fun my-string-lens-map(lst :: List<String>) -> List<Number> block:
  doc: "returns new list where each element is the length of the string in the corresponding position of the input list"
  lst.map(lam(s): string-length(s) end)
  where:
  my-string-lens-map([list: "hello", "world"]) is [list: 5,5]
  my-string-lens-map([list:""]) is [list:0]
end

fun my-alternating(lst :: List) -> List:
  doc: "returns every other element using index-based-access"
  