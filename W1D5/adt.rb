class Stack
    def initialize
        # create ivar to store stack here!
        @pile = []
    end

    def inspect
        "Stack: #{pile.inspect}"
    end

    def push(el)
        # adds an element to the stack
        pile << el
    end

    def pop
        # removes one element from the stack
        pile.pop
    end

    def peek
        # returns, but doesn't remove, the top element in the stack
        pile[-1]
    end

    private
    attr_accessor :pile
end

class Queue
    def initialize
        @pipe = []
    end

    def inspect
        "Queue: #{pipe.inspect}"
    end

    def enqueue(el)
        pipe.unshift(el)
    end

    def dequeue
        pipe.pop
    end

    def peek
        pipe[0]
    end

    private
    attr_accessor :pipe
end

class Map
    def initialize
        @pairs = []
        @keys = [] # memoize
    end

    def inspect
        "Map: #{pairs.inspect}"
    end

    def set(key, value)
        # Search for existing key
        idx = keys.index(key)
        
        if idx.nil?
            pairs << [key, value]
            keys << key
        else
            pairs.[]=(idx, value)
        end
    end

    def get(key)
        idx = keys.index(key)
        idx.nil? ? nil : pairs[idx]
    end

    def delete(key)
        idx = keys.index(key)
        return false if idx.nil?
        
        keys.delete_at(idx)
        pairs.delete_at(idx)
    end

    def show
        self.inspect
    end

    private
    attr_accessor :pairs, :keys
end
