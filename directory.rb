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

def print(students,offset,filter)
  students.each.with_index(offset) do |student,index|
    if filter == ""
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
    elsif filter =~ /^[A-z]+$/ # true if only word
      @filter_type = "whose names begin with"
      if student[:name] =~ /^#{filter}/i
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    else
      @filter_type = "whose names are shorter than"
      if student[:name].length <= filter.to_i
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  end
  @filter = filter
end

def print_footer(students,filter)
  puts "Overall, we have #{students.count} great students#{filter}"
end

def print_filtered_footer(students)
  puts "These are the great students #{@filter_type} #{@filter}"
end
# nothing happens until we call the methods:
students = input_students
print_header
print(students,1,"")
print_footer(students,"")
print(students,1,"a")
print_filtered_footer(students)
print(students,1,"r")
print_filtered_footer(students)
print(students,1,12)
print_filtered_footer(students)
