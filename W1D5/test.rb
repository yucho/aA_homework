require_relative "adt"

# Test cases
puts ("==== Testing Stack ====")
stack = Stack.new
stack.push(3)
stack.push(5)
stack.push(1)
stack.push(2)
p stack
p stack.pop
p stack.peek
p stack


puts
puts ("==== Testing Queue ====")
queue = Queue.new
queue.enqueue(3)
queue.enqueue(5)
queue.enqueue(1)
queue.enqueue(2)
p queue
p queue.dequeue
p queue.peek
p queue


puts
puts ("===== Testing Map =====")
my_map = Map.new
my_map.set(:a, :b)
my_map.set(1, 2)
my_map.set("foo", "bar")
p my_map.show
p my_map.get("foo")
p my_map.get("baz")
p my_map.delete(1)
p my_map.show
