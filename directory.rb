FORMAT_WIDTH = 80 # A Constant (CONST) value
@students = []
@filename = ARGV.first # first argument from the command line

def interactive_menu
  # clear_screen
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
      save_students(@filename)
    when "4"
      if @filename.nil? || @filename == ""
        print "Please enter filename to open: "
        @filename = STDIN.gets.chomp
      else
        print "Please enter filename to open: "
        @filename = STDIN.gets.chomp
      end
      file_load_check(@filename)
    when "9"
      clear_screen
      puts "Goodbye."
      exit
    else
      clear_screen
      puts "I don't know what you meant, try again"
  end
end

# get user input
def print_menu
  puts """
  1. Input the students
  2. Show the students
  3. Save the list #{@filename.nil? || @filename == "" ? "" : "to" } #{@filename}
  4. Load a list
  9. Exit"""
end

def show_students
  if @students.empty?
    clear_screen
    puts "You have no students yet :-("
  else
    print_header
    print_data(@students)
    print_footer(@students)
  end
end

def save_students(filename)
  if @students.empty?
    clear_screen
    puts "No data to save, please input data before attempting to save"
  else
    while @filename == nil || @filename == ""
      print "Please enter filename to save: "
      filename = STDIN.gets.chomp
      @filename = filename
    end
    File.open(filename,"w")do |file|
      @students.each do |student|
        student_data = [student[:name],student[:cohort],student[:age],student[:sex],student[:hobby]]
        csv_line  = student_data.join(",")
        file.puts csv_line
      end
    end
    clear_screen
    puts "Save #{@students.count} to #{@filename}"
  end
end

def load_students(filename)
  @students.clear
  File.open(filename,"r") do |file|
    file.readlines.each do |line|
      name, cohort, age, sex, hobby = line.chomp.split(',')
      students_to_array(name,cohort,age,sex,hobby)
    end
  end
  clear_screen
  puts "Loaded #{@students.count} from #{@filename}"
end

def startup
  return if @filename.nil? # get out of the method if it isn't given
  if File.file?(@filename) # if file exists (exists returns true for directory names, where file does not)
    load_students(@filename)
  else
    load_fail(@filename)
    exit #quit the program
  end
end

def clear_screen
  system "clear"
end

def file_load_check(filename)
  return if filename.nil? # get out of the method if it isn't given

  if File.file?(filename) # if file exists (exists returns true for directory names, where file does not)
    load_students(filename)
    if File.size(filename) <= 0
        puts "file empty, please enter new filename"
        @filename = nil
    end
  else
    load_fail(filename)
  end
end

def load_fail(filename)
  puts "Sorry, #{filename} file doesn't exist!."
  @filename.clear
end

def students_to_array(name,cohort,age,sex,hobby)
  @students << {name: name, cohort: cohort.to_sym, age: age, sex: sex, hobby: hobby}
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
    clear_screen

    puts "\nAre these details correct: ?"

    puts "Name: #{name}\nCohort: #{cohort}\nAge: #{age}\nGender: #{sex}\nFavourite hobby: #{hobby}"
    print "\nY/N?"
    check = STDIN.gets.chomp.upcase

    if check == "Y"
      students_to_array(name,cohort,age,sex,hobby)
      student_count
    end
  end
  clear_screen
  student_count
end

def student_count
  puts "Now we have #{@students.count} student#{@students.count == 1 ? "": "s"}"
end

def print_header
  clear_screen
  puts "The students of Villains Academy".center(FORMAT_WIDTH)
  puts "-------------".center(FORMAT_WIDTH)
end

def print_data(array)
  puts "--------------------------------".center(FORMAT_WIDTH)
  i = 0
  until i >= array.length
    array.each.with_index(1) do |student,index| # requires the each removing
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort), they are #{student[:age]} years old and their favourite hobby is #{student[:hobby]}"
      i += 1
    end
  end
end

def print_footer(array)
  puts "Overall, we have #{array.count} great student#{@students.count == 1 ? "": "s"}".center(FORMAT_WIDTH)
end

clear_screen
startup
puts "Running #{$0}".rjust(80)
interactive_menu
