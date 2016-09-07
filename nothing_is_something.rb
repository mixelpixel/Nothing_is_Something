=begin
1234567891----*----2----*----3----*----4----*----5----*----6----*-----72--*----8----*----9----*--100-------11012345--120
written by pdk (with vim!)

The following are notes, thoughts and code bits from Sandi Metz's talk,
"Nothing is Something"
from: https://www.youtube.com/watch?v=zc9OvLzS9mU
See also: http://www.sandimetz.com/

4 parts
1) SMALLTALK INFECTED
2) CONDITION AVERSE
3) MESSAGE CENTRIC
4) ABSTRACTION SEEKING

*----------------------------------------------------------------------*

1) SMALLTALK INFECTED
https://en.wikipedia.org/wiki/Smalltalk
http://stackoverflow.com/questions/1821266/what-is-so-special-about-smalltalk

=end

puts
puts "----------SMALLTALK INFECTED----------"
puts "----------SENDING MESSAGES TO OBJECTS----------"
puts
# NOTE these are synonymous:
puts "\"1.to_s\" and \"1.send(:to_s)\" are synonymous:"
puts 1.to_s                   # <-- "1"
puts 1.send(:to_s)            # <-- "1"
puts
puts "Does \"1.to_s\" == \"1.send(:to_s)\"?  " + (1.to_s == 1.send(:to_s)).to_s
puts "Ayep... 1 == 1 is " + ((1 == 1) == (1.to_s == 1.send(:to_s))).to_s
puts


# NOTE these are also synonymous:
puts "\"1 + 1\" and \"1.send(:+, 1)\" are also synonymous:"
puts "1 + 1 = " + (1 + 1).to_s                     # <-- "1 + 1 = 2"
puts "1.send(:+, 1) = " + 1.send(:+, 1).to_s       # <-- "1.send(:+, 1) = 2"
puts "In the \".send(:+, 1)\" instance you are sending the"
puts "operator \"+\" to the class \"Fixnum\" (value of '1')"
puts "with the argument (or, 'operand') of \"1\""
puts
puts "Does " + (1 + 1).to_s + " == " + 1.send(:+, 1).to_s + "?  " + ((1 + 1) == (1.send(:+, 1))).to_s
puts


# NOTE What's going on here?
# Why the difference between the true and false arguments?
puts "What is 1?"
puts "1.class is a " + 1.class.to_s                # <-- Fixnum
puts
puts "Fixnum is a CLASS and Fixnums, or Fixnum instances, are objects and they \"know\" things."
puts "Fixnum.instance_methods(false) are:" + Fixnum.instance_methods(false).to_s
puts "A line by line, alphabetically sorted list:"
puts Fixnum.instance_methods(false).sort
puts
puts "Fixnum.instance_methods(true) are: \n" + Fixnum.instance_methods(true).to_s
puts "A much longer line by line, alphabetically sorted list:"
puts Fixnum.instance_methods(true).sort
puts
puts "Can you explain the differences in the true and false lists of instance methods?"
puts
puts "Is 1 == 1 is synonymous with 1.send(:==, 1)? " + ((1 == 1) == 1.send(:==, 1)).to_s
puts "Of course it is. So is (1 == 1).send(:==, (1 == 1)) also true? " + 1.send(:==, 1).send(:==, 1.send(:==, 1)).to_s
puts "We are sending the equal-euqal method to Fixnum :)"


# NOTE http://stackoverflow.com/questions/212407/what-exactly-is-the-singleton-class-in-ruby
puts
puts "Q: What is the true.class? (Hint: it's classy!!) A: " + true.class.to_s
puts "true.class is the \"singleton instance\" of TrueClass"
puts
puts "What does true know? All this stuff..."
puts "TrueClass.instance_methods(false): " + TrueClass.instance_methods(false).to_s
puts TrueClass.instance_methods(false).sort
puts
puts "TrueClass.instance_methods(true): " + TrueClass.instance_methods(true).to_s
puts TrueClass.instance_methods(true).sort
puts
puts "Of note: look into pretty print & require 'pp'"
puts "Also of note: false is the singleton instance of " + false.class.to_s + " and"
puts "nil is the singleton instance of " + nil.class.to_s + "."
puts


