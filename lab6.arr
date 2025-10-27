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
  cases (scores) l:
      