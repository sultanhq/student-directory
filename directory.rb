FORMAT_WIDTH = 54 # A Constant (CONST) value

def interactive_menu
  system "clear"
  @students = []
  loop do
    # system "clear"
    # print menu
    puts """\n
    \n1. Input the students
    \n2. Show the students
    \n9. Exit"""
    # get user input
    selection = gets.chomp
    # do action
    case selection
      when "1"
        @students = input_students
      when "2"
        print_header
        print_data(@students,1,"")
        print_footer(@students,"")
      when "9"
        exit
      else
        puts "I don't know what you meant, try again"
    end
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # crate an empty array

  while true do
    puts "Enter Name:"
    name = gets.chomp # get a name
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
    puts "\nAre these details correct: ?"
    puts "Name: #{name}\nCohort: #{cohort}\nAge: #{age}\nGender: #{sex}\nFavourite hobby: #{hobby}"
    print "Y/N?"
    check = gets.chomp
    if check == "Y"
      @students << {name: name, cohort: cohort.to_sym, age: age, sex: sex, hobby: hobby}
      puts "Now we have #{@students.count} student#{@students.count == 1 ? "": "s"}"
    end
    if @students.empty?
      #####
    end
  end
  # return the array of students
  @students
end

def print_header
  system "clear"
  puts "The students of Villains Academy".center(FORMAT_WIDTH)
  puts "-------------".center(FORMAT_WIDTH)
end

def print_data(array,offset,filter)
  puts "--------------------------------".center(FORMAT_WIDTH)
  i = 0
  until i >= array.length
    array.each.with_index(offset) do |student,index| # requires the each removing
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
      i += 1
    end
  end
  @filter = filter
end

def print_footer(array,filter)
  puts "Overall, we have #{array.count} great students#{filter} ".center(FORMAT_WIDTH)
end

def print_filtered_footer(array)
  puts "These are students #{@filter_type} #{@filter}".center(FORMAT_WIDTH)
end

def print_by_sort(array,sort_key,offset,filter)
  array_by_sort = array.sort_by {|v| v[sort_key]}
  print_data(array_by_sort,offset,filter)
end

def print_by_sort_and_filter(array,sort_key,filter_key,offset,filter)
  array_by_sort_and_filter = array.select { |hash| hash[sort_key.to_sym] == filter_key.to_sym}.sort_by {|v| v[sort_key.to_sym]}.sort_by {|v| v[:name]}
  print_data(array_by_sort_and_filter,offset,filter)
end
# nothing happens until we call the methods:
# students = input_students
# print_header
# print_data(students,1,"")
# print_footer(students,"")
# print_data(students,1,"a")
# print_filtered_footer(students)
# print_data(students,1,"r")
# print_filtered_footer(students)
# print_data(students,1,12)
# print_filtered_footer(students)
# print_by_sort(students,:cohort,1,"") # Stage 8 exercise 8
# print_by_sort_and_filter(students,"cohort","November",1,"")

interactive_menu
