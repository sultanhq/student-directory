FORMAT_WIDTH = 54 # A Constant (CONST) value
@students = []
@filename = ARGV.first # first argument from the command line

def interactive_menu
  # system "clear"
  loop do
    print_menu
    process(STDIN.gets.chomp)# do action
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

# get user input
def print_menu
  puts """
  1. Input the students
  2. Show the students
  3. Save the list to #{@filename}
  4. Load the list from #{@filename}
  9. Exit"""
end

def show_students
  if @students.empty?
    puts "You have no students yet :-("
  else
    print_header
    print_data(@students,"")
    print_footer(@students,"")
  end
end

def save_students(filename = "students.csv")
  #open a file
  file = File.open(filename,"w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name],student[:cohort],student[:age],student[:sex],student[:hobby]]
    csv_line  = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename,"r")
  file.readlines.each do |line|
    name, cohort, age, sex, hobby = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, age: age, sex: sex, hobby: hobby}
  end
  file.close
end

def try_load_students
  if @filename.nil? # get out of the method if it isn't given
    @filename = "students.csv"
    return
  end
  if File.file?(@filename) # if file exists (exists returns true for directory names, where file does not)
    load_students(@filename)
    puts "Loaded #{@students.count} from #{@filename}"
  else
    puts "Sorry, #{@filename} doesn't exist."
    exit #quit the program
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  while true do
    puts "Enter Name:"
    name = STDIN.gets.chomp # get a name
    break if name.empty?
    puts "What cohort is #{name} on? (leave blank for November)"
    cohort = STDIN.gets.chomp

    if cohort.empty?
      cohort = "November"
      puts "November"
    end

    puts "What is #{name}'s age?"
    age = STDIN.gets.chomp
    puts "What is #{name}'s gender?"
    sex = STDIN.gets.chomp
    puts "What is #{name}'s favourite Hobby?"
    hobby = STDIN.gets.chomp
    puts "\nAre these details correct: ?"
    puts "Name: #{name}\nCohort: #{cohort}\nAge: #{age}\nGender: #{sex}\nFavourite hobby: #{hobby}"
    print "Y/N?"
    check = STDIN.gets.chomp

    if check == "Y"
      @students << {name: name, cohort: cohort.to_sym, age: age, sex: sex, hobby: hobby}
      puts "Now we have #{@students.count} student#{@students.count == 1 ? "": "s"}"
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

def print_data(array, filter)
  puts "--------------------------------".center(FORMAT_WIDTH)
  i = 0
  until i >= array.length
    array.each.with_index(1) do |student,index| # requires the each removing

      if filter == ""
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort), they are #{student[:age]} years old and their favourite hobby is #{student[:hobby]}"

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
  puts "Overall, we have #{array.count} great student#{@students.count == 1 ? "": "s"}#{filter} ".center(FORMAT_WIDTH)
end

def print_filtered_footer(array)
  puts "These are students #{@filter_type} #{@filter}".center(FORMAT_WIDTH)
end

def print_by_sort(array, sort_key, filter)
  array_by_sort = array.sort_by {|v| v[sort_key]}
  print_data(array_by_sort,filter)
end

def print_by_sort_and_filter(array, sort_key, filter_key, filter)
  array_by_sort_and_filter = array.select { |hash| hash[sort_key.to_sym] == filter_key.to_sym}.sort_by {|v| v[sort_key.to_sym]}.sort_by {|v| v[:name]}
  print_data(array_by_sort_and_filter, filter)
end

system "clear"
try_load_students
interactive_menu
