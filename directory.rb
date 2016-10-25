FORMAT_WIDTH = 54

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # crate an empty array
  students = []
  # get a name
  # while the name is not empty, repeat this code

  while true do
    puts "Enter Name:"
    name = gets.chomp
    break if name.empty?
    puts "What cohort is #{name} on? (leave blank for November)"
    cohort = gets.chomp
    if cohort.empty?
      cohort = "November"
      puts "November"
    end
    puts "What is #{name}'s age?"
    age = gets.chomp
    puts "What is #{name}'s gender?"
    sex = gets.chomp
    puts "What is #{name}'s favourite Hobby?"
    hobby = gets.chomp
    puts "\nAre these details correct? Y/N"
    puts "Name: #{name}\nCohort: #{cohort}\nAge: #{age}\nGender: #{sex}\nFavourite hobby: #{hobby}"
    print "Y/N?"
    check = gets.chomp
    if check == "Y"
      students << {name: name, cohort: cohort.to_sym, age: age, sex: sex, hobby: hobby}
      puts "Now we have #{students.count} students"
    end
  end
  # return the array of students
  students
end

def print_header
  system "clear"
  puts "The students of Villains Academy".center(FORMAT_WIDTH)
  puts "-------------".center(FORMAT_WIDTH)
end

def print_data(students,offset,filter)
  puts "--------------------------------".center(FORMAT_WIDTH)
  students.each.with_index(offset) do |student,index|
    if filter == ""
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort), they are #{:age} years old and thier favourite hobby is #{:hobby})"
    elsif filter =~ /^[A-z]+$/ # true if only word
      @filter_type = "whose names begin with"
      if student[:name] =~ /^#{filter}/i
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(FORMAT_WIDTH)
      end
    else
      @filter_type = "whose names are shorter than"
      if student[:name].length <= filter.to_i
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(FORMAT_WIDTH)
      end
    end
  end
  @filter = filter
end

def print_footer(students,filter)
  puts "Overall, we have #{students.count} great students#{filter}".center(FORMAT_WIDTH)
end

def print_filtered_footer(students)
  puts "These are the great students #{@filter_type} #{@filter}".center(FORMAT_WIDTH)
end
# nothing happens until we call the methods:
students = input_students
print_header
print_data(students,1,"")
print_footer(students,"")
print_data(students,1,"a")
print_filtered_footer(students)
print_data(students,1,"r")
print_filtered_footer(students)
print_data(students,1,12)
print_filtered_footer(students)
