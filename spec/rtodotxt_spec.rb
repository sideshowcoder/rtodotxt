require "spec_helper"

a_list = "
(A) Buy milk @supermarket +groceries
(C) Fix rtodotxt
(B) get phil to organize +bbq
(A) Buy bread @baker +groceries
Get some coffee +groceries
"

a_list_sorted = "
(A) Buy bread @baker +groceries
(A) Buy milk @supermarket +groceries
(B) get phil to organize +bbq
(C) Fix rtodotxt
Get some coffee +groceries
"

b_list = "
(C) Fix rtodotxt
x 2012-03-13 get phil to organize +bbq
(A) Buy bread @baker +groceries
x 2012-03-13 Buy milk @supermarket +groceries
Get some coffee +groceries
"

b_list_sorted = "
(A) Buy bread @baker +groceries
(C) Fix rtodotxt
Get some coffee +groceries
x 2012-03-13 Buy milk @supermarket +groceries
x 2012-03-13 get phil to organize +bbq
"


a_todo = "Buy milk @supermarket +groceries"
a_todo_prio = "(A) Buy milk @supermarket +groceries"
a_todo_done = "x #{Date.today.to_s} Buy milk @supermarket +groceries"

b_todo = "Get some coffee +groceries"
b_todo_done = "x #{Date.today.to_s} Get some coffee +groceries"
b_todo_prio = "(A) Get some coffee +groceries"


describe Rtodotxt::List do
  
  it "should read a string" do
    tl = Rtodotxt::List.new a_list
    tl.list.should eql a_list
  end    
  
  it "should generate enumerable todos" do
    tl = Rtodotxt::List.new a_list
    tl.each do |t|
      t.class.should eql Rtodotxt::Todo
    end
  end
        
  it "should sort a list by priority" do
    tl = Rtodotxt::List.new a_list
    tl_sorted = Rtodotxt::List.new a_list_sorted
    tl.sort.list.should eql tl_sorted.list
  end

  it "should sort a list by done" do
    tl = Rtodotxt::List.new b_list
    tl_sorted = Rtodotxt::List.new b_list_sorted
    tl.sort.list.should eql tl_sorted.list
  end
  
end

describe Rtodotxt::Todo do
  
  it "should initialize with text" do
    t = Rtodotxt::Todo.new a_todo
    t.text.should eql a_todo
  end
  
  it "should mark as done" do
    t = Rtodotxt::Todo.new b_todo 
    t.done!.text.should eql b_todo_done
  end

  it "should mark as done with priority removed" do
    t = Rtodotxt::Todo.new a_todo_prio 
    t.done!.text.should eql a_todo_done
  end
  
  it "should set priority" do
    t = Rtodotxt::Todo.new b_todo
    t.prio!("A").should eql b_todo_prio
  end
  
  it "should unset priority" do
    t = Rtodotxt::Todo.new b_todo_prio
    t.prio!("").should eql b_todo
  end
  
  it "should raise Argument error on illegal priority" do
    t = Rtodotxt::Todo.new b_todo_prio
    lambda { t.prio!("ABC") }.should raise_error
  end
    
  it "should give its contexts" do
   t = Rtodotxt::Todo.new "(C) +bbq @supermarket go +get some +bbq stuff @home for @home" 
   t.contexts.should eql ["supermarket", "home"]
  end
  
  it "should return its projects" do
    t = Rtodotxt::Todo.new "(C) +bbq @supermarket go +get some +bbq stuff @home for @home" 
    t.projects.should eql ["bbq", "get"]
  end
    
  it "should return its priority" do
    t = Rtodotxt::Todo.new "(C) something"
    t.prio.should eql "C"
  end
  
  it "should return empty string for no priority" do
    t = Rtodotxt::Todo.new "something"
    t.prio.should eql ""
  end
  
end