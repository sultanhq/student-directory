def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # crate an empty array
  students = []
  # get a name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student has to the array
    students << {name: name, cohort: :November}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students,letter_filter)
  students.each.with_index(1) do |student,index|
    if student[:name] =~ /^#{letter_filter}/i
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
  @filter = letter_filter
end

def print_footer(students,filter)
  puts "Overall, we have #{students.count} great students#{filter}"
end

def print_filtered_footer(students)
  puts "These are the great students whose names begin with #{@filter}"
end
# nothing happens until we call the methods:
students = input_students
print_header
print(students,"")
print_footer(students,"")
print(students,"a")
print_filtered_footer(students)
print(students,"r")
print_filtered_footer(students)
