require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def create_book
    print 'title : '
    title = gets.chomp
    print 'author : '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
    puts ''
  end

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission: [Y/N]? '
    parent_permission = gets
    permission = true if parent_permission.downcase == 'y'
    permission = false if parent_permission.downcase == 'n'
    @persons.push(Student.new('Unknown', age, name, parent_permission: permission))
    puts 'Person created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets
    @persons.push(Teacher.new(specialization, age, name))
    puts 'Person created successfully'
  end

  def create_person
    print 'Do you want to create a students (1) or a teacher (2)? [input the number]: '
    option = gets
    print option
    case Integer(option)
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid option'
    end
  end

  def list_all_people
    @persons.each do |person|
      type = person.class
      puts "[#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_all_books
    @books.each { |book| puts "Title: #{book.title} , Author : #{book.author}" }
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, idx| puts "#{idx}) Title: #{book.title}, Author: #{book.author}" }
    boox_index = Integer(gets.chomp)
    puts 'Select a person from the following list by number (not id)'
    @persons.each_with_index { |person, idx| puts "#{idx}) Name: #{person.name}, Id: #{person.id}, Age: #{person.age}" }
    person_index = Integer(gets.chomp)
    print 'Date: '
    date = gets.chomp
    @rentals.push(Rental.new(date, @books[boox_index], @persons[person_index]))
    puts 'Rental created successfully'
  end

  def dispaly_rentals_by_id
    print 'ID of person: '
    id = Integer(gets.chomp)
    person = @persons.find { |p| p.id == id }
    puts 'Rentals: '
    person.rentals.each { |rental| puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}" }
  end

  def display_options
    puts 'Please choose an option by entering a number'
    puts '1- List all books'
    puts '2- List all people'
    puts '3- Create a person'
    puts '4- Create a book'
    puts '5- Create a rental'
    puts '6- List all rentals for a given person Id'
    puts '7- Exit'
  end

  def excute(option)
    case option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      dispaly_rentals_by_id
    when '7'
      puts 'thanks for using this app'
    else
      puts 'Invalid option'
    end
  end

  def run
    loop do
      display_options
      option = gets.chomp
      excute(option)
      break if option == '7'
    end
  end
end
