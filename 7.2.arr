use context starter2024

data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end

# Example
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)

# merge points (nodes with two children)
merge-1 = merge(12,stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

fun total-flow(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => total-flow(left) + total-flow(right)
    | stream(flow) => flow
  end
where:
  total-flow(stream-a) is 5
  total-flow(main-river) is 16
end

fun count-merges(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => 1 + count-merges(left) + count-merges(right)
    | stream(flow) => 0
  end
where:
  count-merges(stream-a) is 0
  count-merges(main-river) is 2
end

fun count-stream(r):
  doc: "count how many individual streams feed into a river network"
  cases(River) r:
    | merge(width, left, right) => count-stream(left) + count-stream(right)
    | stream(flow) => 1
  end
where:
  count-stream(merge-1) is 2
  count-stream(main-river) is 3
end

fun max-width(r):
  doc: "finds the maximum width among all merge points in a river network"
  cases(River) r:
    | merge(width, left, right) => num-max(width,num-max(max-width(left),max-width(right)))
    | stream(flow) => 0
  end
where:
  max-width(main-river) is 15
  max-width(merge-1) is 12
end

