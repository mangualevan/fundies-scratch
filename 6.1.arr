use context dcic2024
data MobileRecord:
    phone(title :: String, model :: String, color :: String, storage :: Number)
end

phone-1 = phone("iPhone", "13 Pro", "Blue", 64)
phone-2 = phone("iPhone", "17 Pro", "Orange", 512)

phone-2.storage

fun compute-cost(p :: MobileRecord) -> Number:
  doc: "Computes phone cost based on storage capacity"
  base-price = 500
  price-per-gb = 2
  base-price + (p.storage * price-per-gb)
where:
  compute-cost(phone-1) is 628
  compute-cost(phone-2) is 1524
end

fun compute-cost-condition(p :: MobileRecord) -> Number:
  doc: "Computes phone cost based on storage capacity"
  base-price = if p.model == "13 Pro":
    799
  else if p.model == "17 Pro":
    1399
  else:
    899
  end
    # storage
    storage-cost = if p.storage <= 64:
      0
    else if p.storage <= 128:
      100
    else if p.storage <= 256:
      200
    else if p.storage <= 512:
      400
    else:
      600
    end
    # color
    color-cost= if (p.color == "Orange") or (p.color == "Purple"):
      150
    else:
      0
    end
    
    base-price + storage-cost + color-cost
  
where:
    compute-cost-condition(phone-1) is 799 + 0 + 0
    compute-cost-condition(phone-2) is 1399 + 400 + 150
end

data Priority:
  | low
  | medium
  | high
end

task-1-priority = low
task-2-priority = high
task-3-priority = medium

check:
  is-Priority(task-1-priority) is true
  is-low(task-1-priority) is true
  is-high(task-2-priority) is true
end

data Task:
  | task(description :: String, priority :: Priority)
  | note(description :: String)
end

task-1 = task("Study for exams", high)
task-2 = task("Watch a series", low)
task-3 = task("Go for groceries", medium)

fun describe(t :: Task) -> String:
  cases(Task) t:
    | task(d,p) => "TASK: " + d
    | note(d) => d
  end
end

describe(task-1)

fun describe-new(t :: Task) -> String:
  cases(Task) t:
    | task(d,p) => 
      priority = cases (Priority) p:
        | low => "! TASK: "
        | medium => "!! TASK: "
        | high => "!!! TASK: "
      end
      priority + d
    | note(d) => "Note: " + d
  end
end

describe-new(task-1)