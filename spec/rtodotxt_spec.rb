require "rtodotxt"

a_list = "
(A) Buy milk @supermarket +groceries
(C) Fix rtodotxt
(B) get phil to organize +bbq
(A) Buy bread @baker +groceries
Get some coffee +groceries
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
        
  it "should filter a list by word"

  it "should sort a list by priority"

  it "should sort a list by done"
  
  it "should list contexts"
  
  it "should list projects"
  
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
    t.prio!.should eql b_todo
  end
  
  it "should raise Argument error on illegal priority" do
    t = Rtodotxt::Todo.new b_todo_prio
    lambda { t.prio!("ABC") }.should raise_error
  end
  
  it "should append to text"
  
  it "should give its contexts"
  
  it "should return its projects"
  
  it "should return its priority"
  
end