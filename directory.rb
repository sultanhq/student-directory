student_count = 11
# let's put all students into an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex Delarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffery Baratheon",
  "Norman Bates"
]
# and then print them
puts "The students of Villains Academy"
puts "-------------"
students.each {|e| puts e} # I am using "e" as reference to element of the array
=begin
I could have also used this version of of .each:
students.each do |student|
  puts student
end
=end

# finally, we print the total number of students
puts "Overall, we have #{students.count} great students"
