require 'json'
require './item'
require './book-label/book'
require './book-label/label'

items = []
labels = []

at_exit do
  # Serialize the items and labels arrays to JSON
  items_json = items.to_json
  labels_json = labels.to_json

  # Save the JSON strings to files
  File.write('items.json', items_json)
  File.write('labels.json', labels_json)
end

def list_items(items)
  items.each do |item|
    puts "ID: #{item.id}"
    puts "Title: #{item.title}"
    # puts "Genre: #{item.genre}"
    # puts "Author: #{item.author}"
    # puts "Source: #{item.source}"
    # puts "Label: #{item.label}"
    puts "Publish date: #{item.publish_date}"
    puts "Archived: #{item.archived}"
    puts ''
  end
end

def move_item_to_archive(items)
  puts 'Enter the ID of the item to move to the archive:'
  item_id = gets.chomp.to_i
  # Find the item with the given ID
  item = items.find { |i| i.id == item_id }
  if item
    item.move_to_archive
    puts 'Item moved to the archive'
  else
    puts 'Item not found'
  end
end

def add_new_book(items)
  puts 'Enter the publish date (YYYY-MM-DD):'
  publish_date = Date.parse(gets.chomp)
  puts 'Enter the title:'
  title = gets.chomp
  puts 'Enter the cover state:'
  cover_state = gets.chomp
  book = Book.new(title, cover_state, publish_date, archived: false)
  # puts 'Enter the genre:'
  # book.genre = gets.chomp
  # puts 'Enter the author:'
  # book.author = gets.chomp
  # puts 'Enter the source:'
  # book.source = gets.chomp
  # puts 'Enter the label:'
  # book.label = gets.chomp
  items << book
end

def add_new_label(labels)
  puts 'Enter the title:'
  title = gets.chomp
  puts 'Enter the color:'
  color = gets.chomp
  label = Label.new(title, color)
  labels << label
end

def list_labels(labels)
  labels.each do |label|
    puts "ID: #{label.id}"
    puts "Title: #{label.title}"
    puts "Color: #{label.color}"
    puts "Items: #{label.items.map(&:id).join(', ')}"
    puts ''
  end
end

loop do
  puts 'Choose an option:'
  puts '1. List all books'
  puts '2. List all labels'
  puts '3. Add a new book'
  puts '4. Add a new label'
  puts '5. Quit'

  choice = gets.chomp
  case choice
  when '1'
    # List all books
    items.select { |item| item.is_a?(Book) }.each do |book|
      puts "ID: #{book.id}"
      puts "Title: #{book.title}"
      puts "Publish date: #{book.publish_date}"
      puts "Cover state: #{book.cover_state}"
      puts "Archived: #{book.archived}"
      puts ''
    end
  when '2'
    # List all labels
    list_labels(labels)
  when '3'
    # Add a new book
    add_new_book(items)
  when '4'
    # Add a new label
    add_new_label(labels)
  when '5'
    break
  else
    puts 'Invalid choice'
  end
end
