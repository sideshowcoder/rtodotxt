require "rtodotxt/version"
require "date"

module Rtodotxt
  
  class List
    include Enumerable
    include Comparable
    
    def initialize list
      @list = self.class.gen_list_from_string list
    end
    
    def <=>(anOther)
    end
    
    def each &block
      @list.each { |todo| block.call todo }
    end
    
    # Split a string by each line and generate an array of todos
    def list=( str )
      @list = self.class.gen_list_from_string str
    end
    
    # Join the todo text together to return the list 
    def list
      str = @list.map { |t| t.text }.join "\n"
      # the result must end with a newline!
      str << "\n"
    end
    
    def self.gen_list_from_string str
      str.split( "\n" ).map!{ |line| Todo.new line }
    end
           
  end
  
  class Todo
    
    attr_accessor :text
    
    def initialize text
      @text = text
    end
    
    def done!
      @text = "x #{Date.today.to_s} " + @text.gsub(/\(.\)\s/, '')
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
      prio = @text.match( /\((.)\)/ )
      prio.nil? ? "" : prio[1]
    end
    
    def contexts
      projects = @text.scan( /@(\S+)/ )
      projects.uniq.flatten      
    end
    
    def projects
      projects = @text.scan( /\+(\S+)/ )
      projects.uniq.flatten
    end
    
  end

end
