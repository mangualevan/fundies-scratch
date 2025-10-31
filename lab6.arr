use context dcic2024

include csv
include data-source
include lists

student_score = load-table:
  Name :: String,
  Surname :: String,
  Email :: String,
  Score :: Number
  
  source: csv-table-file("students_gate_exam_score.csv", default-options)
    
  sanitize Score using num-sanitizer
end

student_score

top-scores = order-by(student_score,"Score", false)

top-scores

top-scores.row-n(0)
top-scores.row-n(1)
top-scores.row-n(2)

data StudentRecord:
    Student(name :: String, surname :: String, score :: Number)
end

s1 = Student("Ethan","Gray",97)

s2 = Student("Oscar","Young",92)

s3 = Student("Adrian","Bennet",80)

scores :: List<Number> = link(s1.score, link(s2.score, link(s3.score, empty)))

fun A-scores(l):
  cases (List) l:
    | empty => 0
    | link(f,r) => if f > 90: 1 + A-scores(r)
      else: 0 + A-scores(r)
      end
  end
where:
  A-scores([list:97,92,80]) is 2
      end

all-emails = student_score.get-column("Email")

all-emails

fun get-domain(string) -> String:
  doc: "Splits email at '@' and '.' to get university name"
  string-split(string-split(string, "@").get(1) , ".").get(0)
  end

uni-domain = map(get-domain, all-emails)

uni-domain

distinct(uni-domain)

fun replace-domain(email :: String) -> String:
  doc: "Splits email at '@', checks if domain is 'nulondon.ac.uk', and replaces it with 'northeastern.edu'"
  username = string-split(email, "@").get(0)
  domain = string-split(email, "@").get(1)
  if domain == "nulondon.ac.uk":
    username + "@northeastern.edu"
  else:
    email
  end
end

all-emails-transformed = map(replace-domain, all-emails)

all-emails-transformed