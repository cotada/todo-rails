# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Task.destroy_all # Clear existing tasks (optional, but good practice for development)

# Create sample tasks
tasks = [
  {
    title: 'Complete Ruby on Rails Tutorial',
    description: 'Work through the entire Rails tutorial to build a strong foundation',
    completed: false
  },
  {
    title: 'Add Authentication',
    description: 'Implement user authentication using Devise',
    completed: false
  },
  {
    title: 'Style the Application',
    description: 'Add CSS and make the application look professional',
    completed: false
  }
]

tasks.each do |task|
  Task.create!(task)
end

puts 'Sample tasks have been created!'