use context dcic2024
data TaxonomyTree:
  node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

# Example: Part of the cat family
lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])

house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])

felidae = node("Family", "Felidae", [list: panthera, felis])

fun count-nodes(t :: TaxonomyTree) -> Number:
   1 + count-nodes-children(t.children)
where:
  count-nodes(lion) is 1
  count-nodes(panthera) is 4
  count-nodes(felis) is 3
  count-nodes(felidae) is 8
end

fun count-nodes-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-nodes(first) + count-nodes-children(rest)
  end
end

fun count-species(t :: TaxonomyTree) -> Number:
  this-count = if t.rank == "Species": 1 else: 0 
  end
  this-count + count-species-children(t.children)
where:
  count-species(lion) is 1
  count-species(panthera) is 3
  count-species(felis) is 2
  count-species(felidae) is 5
end

fun count-species-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first,rest) => count-species(first) + count-species-children(rest)
  end
end

fun count-rank(t :: TaxonomyTree, rank :: String) -> Number:
  this-count = if t.rank == rank: 1 else: 0
  end
  this-count + count-rank-children(t.children, rank) 
where:
  count-rank(lion, "Species") is 1
  count-rank(panthera, "Species") is 3
  count-rank(felis, "Species") is 2
  count-rank(felidae, "Species") is 5
end

fun count-rank-children(c :: List<TaxonomyTree>, rank :: String) -> Number:
  cases (List) c:
    | empty => 0
    | link(first,rest) => count-rank(first, rank) + count-rank-children(rest, rank) 
  end
end

fun taxon-height(t :: TaxonomyTree) -> Number:
  