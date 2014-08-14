require "rtodotxt/version"
require "date"

module Rtodotxt

  class List < Array
    def initialize list
      super self.class.gen_list_from_string list
    end

    # Split a string by each line and generate an array of todos
    def read str
      super self.class.gen_list_from_string str
    end

    # Join the todo text together to return the list
    def print
      str = self.map { |t| t.text }.join "\n"
      # the result must end with a newline!
      str << "\n"
    end

    def self.gen_list_from_string str
      str.split("\n").map! do |line|
        Todo.new line unless line.empty?
      end
    end
  end

  class Todo
    include Comparable
    attr_accessor :text

    def initialize text
      @text = text
    end

    # Compare todos, the order is reversed so that a printed list is in correct
    # order
    def <=> a_todo
      if done?
        a_todo.done? ? 0 : 1
      elsif a_todo.prio.empty? || prio.empty?
        if a_todo.prio.empty? && prio.empty?
          0
        elsif a_todo.prio.empty?
          -1
        else
          1
        end
      else
        prio <=> a_todo.prio
      end
    end

    def done!
      @text = "x #{Date.today.to_s} " + @text.gsub(/\(.\)\s/, '') unless done?
      # return self to allow method chaining
      self
    end

    def prio! p
      if p == ""
        # Remove the priority
        @text.gsub!(/\(.\)\s/, '')
      elsif p.match(/\A.\Z/)
        # Single char to be used as priority
        @text = "(#{p.match(/\A.\Z/)[0].upcase}) #{@text}"
      else
        raise ArgumentError, "Illegal priority", caller
      end
    end

    def prio
      # Match the priority from the string
      prio = @text.match(/\((.)\)/)
      prio.nil? ? "" : prio[1]
    end

    def done?
      # if todo text starts with x than it is done
      @text.match( /\Ax\s/ ).nil? ? false : true
    end

    def contexts
      contexts = @text.scan(/@(\S+)/)
      contexts.uniq.flatten
    end

    def projects
      projects = @text.scan(/\+(\S+)/)
      projects.uniq.flatten
    end

  end

end
