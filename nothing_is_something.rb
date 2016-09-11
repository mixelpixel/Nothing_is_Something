=begin
1234567891----*----2----*----3----*----4----*----5----*----6----*-----72--*----8----*----9----*--100-------11012345--120
written by pdk (with vim!)

The following are notes, thoughts and code bits from Sandi Metz's talk,
"Nothing is Something"
from: https://www.youtube.com/watch?v=zc9OvLzS9mU
See also: http://www.sandimetz.com/

@2m25s The one thing: What you need to know about objects

@ 3m15s
4 part lecture:
1) SMALLTALK INFECTED
2) CONDITION AVERSE
3) MESSAGE CENTRIC
4) ABSTRACTION SEEKING

*----------------------------------------------------------------------*

1) SMALLTALK INFECTED: The BIG IDEA of 'Special" syntax.
https://en.wikipedia.org/wiki/Smalltalk
http://stackoverflow.com/questions/1821266/what-is-so-special-about-smalltalk

=end

puts
puts "----------SMALLTALK INFECTED----------"
puts "----------SENDING MESSAGES TO OBJECTS----------"
puts
# @ 4m05s NOTE these are synonymous:
puts "\"1.to_s\" and \"1.send(:to_s)\" are synonymous:"
puts 1.to_s                   # <-- "1"
puts 1.send(:to_s)            # <-- "1"
puts
puts "Does \"1.to_s\" == \"1.send(:to_s)\"?  " + (1.to_s == 1.send(:to_s)).to_s
puts "Ayep... 1 == 1 is " + ((1 == 1) == (1.to_s == 1.send(:to_s))).to_s
puts


# @ 4m27s NOTE these are also synonymous:
puts "\"1 + 1\" and \"1.send(:+, 1)\" are also synonymous:"
puts "1 + 1 = " + (1 + 1).to_s                     # <-- "1 + 1 = 2"
puts "1.send(:+, 1) = " + 1.send(:+, 1).to_s       # <-- "1.send(:+, 1) = 2"
puts "In the \".send(:+, 1)\" instance you are sending the"
puts "operator \"+\" to the class \"Fixnum\" (value of '1')"
puts "with the argument (or, 'operand') of \"1\""
puts
puts "Does " + (1 + 1).to_s + " == " + 1.send(:+, 1).to_s + "?  " + ((1 + 1) == (1.send(:+, 1))).to_s
puts


# @ 4m50s NOTE What's going on here?
# Why the difference between the true and false arguments?
puts "What is 1?"
puts "1.class is a " + 1.class.to_s                # <-- Fixnum
puts
puts "The BIG IDEA here: the 1+1=2 syntax is a 'Special' syntax - just so math feels normal"
puts "BUT, in reality - we are just sending a message to an object."
puts
puts "Fixnum is a CLASS and Fixnums, or Fixnum instances like 1, or 2 or 3, etc..."
puts "are objects and they \"know\" things... such as the plus operator, '+'."
puts
puts "Fixnum.instance_methods(false) are:" + Fixnum.instance_methods(false).to_s
puts "A line by line, alphabetically sorted list:"
puts Fixnum.instance_methods(false).sort
puts
puts "Fixnum.instance_methods(true) are: \n" + Fixnum.instance_methods(true).to_s
puts "A much longer line by line, alphabetically sorted list:"
puts Fixnum.instance_methods(true).sort
puts

# @ 5m35s NOTE OT: Can you explain the differences in the true and false lists of instance methods?
puts "Is 1 == 1 synonymous with 1.send(:==, 1)? " + ((1 == 1) == 1.send(:==, 1)).to_s
puts "Of course it is. So is (1 == 1).send(:==, (1 == 1)) also true? " + 1.send(:==, 1).send(:==, 1.send(:==, 1)).to_s
puts "We are sending the equal-equal method to Fixnum :)"
puts


# @ 5m48s NOTE http://stackoverflow.com/questions/212407/what-exactly-is-the-singleton-class-in-ruby
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


# NOTE OT: look into pretty print & require 'pp'
# @ 6m23s
puts "Of note: false is the singleton instance of " + false.class.to_s + " and"
puts "nil is the singleton instance of " + nil.class.to_s + "."
puts
puts "Booleans in Ruby have a 'Special' syntax which Smalltalk does not."
# @ 6m46s
puts "e.g. Smalltalk ONLY has six keywords: \n\ttrue, false, nil, self, super, thisContext."
puts "Ruby Keywords include:"
puts "\talias, and, BEGIN, begin, break, case, class, def, defined?, do"
puts "\telse, elsif, END, end, ensure, false, for, if, in, module, next, nil"
puts "\tnot, or, redo, rescue, retry, return, self, super, then, true"
puts "\tundef, unless, until, when, while, yield"
puts
puts "Pay special attention to >>> if <<<"
puts
puts "A special syntax for dealing with that Boolean object..."
puts
# @ 7m27s 
puts """\
if ( 1 == 1 )             # ALSO: \"if 1.send(:==, 1)\"
  'is true'
else
  'is false'
end                       ==> 'is true'

NOTE - this is the same as:

if ( true )
  'is true'
else
  'is false'
end                       ==> 'is true'
"""
puts
# NOTE OT: the first conditionals syntax returns the string
# in irb without puts, but not from a script. Why?
# Odd behaviour:
puts "Why do only two of the three conditionals print?"

# This doesn't put anything to screen:
if true
  'is true_1'
else
  'is false'
end

puts "Seriously, why? Or better yet: how?"

# But this does:
if true
  puts 'is true_2'
else
  puts 'is false'
end

# And this works without "puts":
def truthiness
  if 1.send(:==, 1)
    'is true_3'
  else
    'is false'
  end
end

puts truthiness
puts truthiness.class
puts "Weird."
puts
puts "BUT - TO THE POINT: in Ruby these conditionals are more like \"if ( 'truthy' )\", then..."
puts """\
if ( truthy )
  code to evaluate when 'truthy'
else
  code to evaluate when 'falsey'
end

OR...

if ( some object whose type I know)
  code to do some stuff
else
  code to do some other stuff
end

BUT!!!!!!!!!!!!!!!!!!!!1
We don't do type checking in Object Oriented Design.
In fact, we don't do conditionals in Object Oriented Design,
We just want to SEND A MESSAGE TO AN OBJECT.
Procedural languages LOVE conditions: BREAK THIS HABIT
IT IS A CRUTCH!
\"IF\" is an enabler
and can prevent you from using the power of objects.
\"IF\" - in the words of Admiral Akbar - is a TRAP!!!"""

# Windows only:
# system('start https://youtu.be/4F4qzPbcFiA')

# @9m15s---------- MONKEY PATCH TrueClass ---------- https://youtu.be/zc9OvLzS9mU?t=9m15s

puts








