# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'UsersMembers.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
	t = User.new
	t.name = row['Name']
	t.job = row['Job']
	t.email = row['Email']
	t.shoretel = row['ShoreTel']
	t.cell = row['Cell']
	t.fax = row['Fax']
	t.group = row['MemberOf']
	t.save
	puts "#{t.name} saved"
end

puts "There are now #{User.count} rows in the User table"