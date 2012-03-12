require "rtodotxt/version"
require "date"

module Rtodotxt
  
  class List
    include Enumerable
    
    def initialize list
      @list = self.class.gen_list_from_string list
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
      return self
    end
    
  end

end
