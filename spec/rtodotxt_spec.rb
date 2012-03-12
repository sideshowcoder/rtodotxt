require "rtodotxt"

a_list = "
(A) Buy milk @supermarket +groceries
(C) Fix rtodotxt
(B) get phil to organize +bbq
(A) Buy bread @baker +groceries
Get some coffee +groceries
"

a_todo = "(A) Buy milk @supermarket +groceries"
a_todo_done = "x #{Date.today.to_s} Buy milk @supermarket +groceries"

b_todo = "Get some coffee +groceries"
b_todo_done = "x #{Date.today.to_s} Get some coffee +groceries"

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

  it "should mark as done with priority removed"
  
  it "should set priority"
  
  it "should unset priority"
  
  it "should "

end