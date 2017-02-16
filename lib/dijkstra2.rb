require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}
  possible_paths = PriorityMap.new do |a,b|
    a[:cost] <=> b[:cost]
  end
  source.out_edges.each do |edge|
    possible_paths[edge.to_vertex] = {
      cost: +1.0/0.0,
      prev: nil
    }
  end
  possible_paths[source] = {
    cost: 0,
    prev: nil
  }
  until possible_paths.empty?
      vertex, data = possible_paths.extract
      shortest_paths[vertex] = data

      path_to_vertex_cost = shortest_paths[vertex][:cost]

        vertex.out_edges.each do |edge|
          next if shortest_paths.has_key?(edge.to_vertex)
          opt1 = path_to_vertex_cost + edge.cost
          opt2 = possible_paths[edge.to_vertex][:cost]

          if opt1 < opt2
            possible_paths[edge.to_vertex] = {
              cost: opt1,
              prev: vertex
            }
          end
        end
    end
  shortest_paths
end
