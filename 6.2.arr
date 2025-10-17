use context dcic2024
dummy-list = [list: 1,2,3,4]

dummy-list

dummy-list.first

dummy-list1 = dummy-list.rest
dummy-list2 = dummy-list1.rest
dummy-list2.first

check:
  [list:        ] is empty
  [list: 1      ] is link(1, empty)
  [list: 1, 2   ] is link(1, link(2, empty))
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end

[list: 7,8,9,10,11,12].length

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f,r) => 1 + my-len(r)
  end
where:
  my-len([list: 7,8,9]) is 3
  my-len([list: 8,9]) is 2
  my-len([list: 9]) is 1
  my-len([list: ]) is 0
  
  my-len([list: 55,56,57,58]) is 1 + my-len([list: 56,57,58])
  
 my-len([list: 55,56,57,58]) is 2 + my-len([list: 56,57,58].rest)
  my-len([list: 55,56,57,58]) is 1 + my-len([list: 55,56,57,58].rest)  
end
