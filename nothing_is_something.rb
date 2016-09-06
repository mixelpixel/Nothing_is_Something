#234567891----*----2----*----3----*----4----*----5----*----6----*-----72--*----8----*----9----*--100-----------------120
# written by pdk with vim
=begin
The following are notes, thoughts and code bits from Sandi Metz's talk, "Nothing is Something"
https://www.youtube.com/watch?v=zc9OvLzS9mU
SENDING MESSAGES TO OBJECTS
SmallTalk Infected
CONDITION AVERSE
MESSAGE CENTRIC
ABSTRACTION SEEKING
=end


# NOTE these are synonymous:
puts 1.to_s         # <-- "1"
puts 1.send(:to_s)  # <-- "1"

puts "Does " + 1.to_s + " == " + 1.send(:to_s) + "?  " + (1.to_s == 1.send(:to_s)).to_s 
puts


# NOTE these are also synonymous:
puts "1 + 1 = " + (1 + 1).to_s                # <-- "1 + 1 = 2"
puts "1.send(:+, 1) = " + 1.send(:+, 1).to_s  # <-- "1 + 1 = 2"

# In the ".send(:+, 1)" instance you are sending the operator "+" to the
# class "Fixnum" (value of '1') with the argument (or, 'operand') of "1"

puts "Does " + (1 + 1).to_s + " == " + 1.send(:+, 1).to_s + "?  " + ((1 + 1) == (1.send(:+, 1))).to_s
puts


# NOTE What's going on here?
# Why the difference between the true and false arguments?

puts "1.class is a " + 1.class.to_s             # <-- Fixnum
puts
puts "Fixnum.instance_methods(false) are: \n" + Fixnum.instance_methods(false).to_s
puts
puts "Fixnum.instance_methods(true) are: \n" + Fixnum.instance_methods(true).to_s
puts


