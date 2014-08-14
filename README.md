Rtodotxt
========
Work with [todo.txt](http://todotxt.com/) files from ruby.

Usage
-----
Work with any todo.txt formatted file

```ruby
require 'rtodotxt'

list = Rtodotxt::List.new(File.read('./todo.txt')) # load list
list.first # first todo
list.first.done! # mark first todo done
list.first.done? # => true

list.map(&:contexts).flatten.uniq # get all contexts
list.map(&:projects).flatten.uniq # get all projects
```

License
-------
MIT


