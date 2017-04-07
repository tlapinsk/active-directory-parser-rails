require 'csv'
require 'ffaker'

# Seed the Job table without importing a CSV
# Uncomment the puts below to see "Seeding Jobs table with data"
puts "Seeding Jobs table with data"
title = ["Chief Information Officer", "Chief Financial Officer", "Senior Director, IT", "Senior Director, Marketing", "Senior Director, Business Applications", "Senior Director, User Experience & Design", "Chief Executive Officer", "Director, Product Management", "Chief Operations Officer", "VP, Corporate Development", "EVP, Market Development", "VP, Finance", "Chief Marketing Officer", "Business Development Manager", "System Administrator", "Senior Web Developer", "Junior Web Developer", "Business Analyst", "Payroll Administrator", "Human Resources Assistant", "Executive Assistant", "Recruiter", "Accountant", "IT Support Manager", "Business Intelligence Analyst", "IT Project Manager", "Product Owner", "Product Manager", "Analyst", "User Experience Designer", "User Interface Designer", "Business Development Analyst", "Customer Support Representative", "Marketing Manager", "Account Manager", "Accounts Payable Specialist", "Administrative Assistant", "Associate Project Manager", "Area Sales Manager", "Business Systems Analyst I", "Business Systems Analyst II", "Business Systems Architect", "Buyer", "Customer Experience Manager", "Customer Experience Lead", "Division Sales Manager", "Retail Manager", "Driver", "Facilities Assistant", "Supply Manager", "Financial Analyst", "Human Resources Generalist I", "Human Resources Generalist II", "Human Resources Coordinator", "Inventory Analyst", "Janitor", "Management Trainee", "Inventory Clerk", "Maintenance Supervisor", "Plant Manager", "Inside Sales Manager", "Outside Sales Manager", "Sanitation Manager", "Supply Chain Manager", "Sales Analytics Manager", "QA Manager", "Project Management Manager", "Engineering Manager", "Office Manager", "Manufacturing Coordinator", "Manufacturing Worker", "Manufacturing Operator", "Materials Manager", "Materials Planner", "Mechanic", "Office Administrator", "Personal Assistant", "Project Engineering Manager", "R&D Assistant", "R&D Coordinator", "R&D Product Manager", "Innovation Manager", "Innovation Product Manager", "Innovation Project Manager", "Receptionist", "Regional Sales Manager", "Training Coordinator", "Senior Training Coordintator", "Spokerperson", "PR Manager", "Welder"]
# Seed Job table with raw data
91.times do |index|
	title = Job.create(
		title: title[index -1]
	)
	# Display all data that was seeded in the table
	puts title.inspect
end

# Seed the Group table without importing a CSV
# Uncomment the puts below to see "Seeding group table with random group data"
puts "Seeding groups table with data"
random_group = ["Accident Reporting-Utah", "Accident Reporting-San Diego", "Accident Reporting-Boston", "Accounting", "Accounts Payabale", "Accounts Receivable", "Backups", "Change Management", "Concur Corporate", "Concur Users", "Consumer Relations", "Issues", "Engineering-San Diego", "Engineering-Utah", "Engineering-Boston", "Executive Staff", "Inside Sales", "International", "IT", "IT Infrastructure", "IT Security", "IT Steering Committee", "Marketing", "Planning", "New Products", "Ops", "Oracle", "Outside Sales", "Packaging", "Paypal", "Payroll", "QA", "Research and Development", "Innovation", "Safety", "Sourcing", "Staff-All", "Staff-San Diego", "Staff-Utah", "Staff-Boston", "Warehouse", "Debug", "Test", "MySQL DBA", "Dynamix", "Salesforce", "Oracle-BI", "Auditing", "Customer Experience", "Human Resources", "Supply Chain", "Inventory", "Retail-West", "Retail-North", "Retail-South", "Retail-East", "Retail-International", "Oracle Sales", "Oracle Pricing", "Oracle Admin", "Process Engineer", "Product Dev", "Purchasing", "Reports", "Shipping", "System Administrator", "Tax", "User Management", "Employee", "Project Supervisor", "Store-Account", "Store-Accounting Boston", "Store-Accounting Utah", "Store-Accounting San Diego", "Store-Customer Experience", "Store-Consultant", "Store-Databases", "Store-Engineer", "Store-People and Culture", "Store-Main", "Store-Manufacturing", "Store-Payroll", "Store-Planning", "Store-Prod", "Store-Quality Assurance", "Store-Safe", "Store-Warehouse", "VPN", "BI-Warehouse", "BI-Prod", "BI-QA", "BI-Test", "BI-Sales", "BI-Function", "BI-Dashboards", "Trello-Admin", "Trello-Users", "Trello-Consultants", "Google Apps", "Microsoft Office", "MS Project", "Shoretel", "AWS", "AWS-S3", "AWS-Redshift", "Azure Active Directory Admin", "Azure Active Directory User", "Azure Cloud", "Spotify-Enterprise", "Apple Music Enterprise", "Apple iPhone Users", "Apple iPad Users", "Apple Macbook Pro Users", "Apple Macbook Air Users", "Apple Macbook Users", "Apple Mac Pro Users", "Dell Users"]
117.time do |index|
	group = Group.create!(
		group: random_group[index - 1]
	)
	# Display all data that was seeded in the table
	puts group.inspect
end

# # Seed the User table with high ranking officers without using a CSV
# # Uncomment the puts to see "seeding users"
# # puts "seeding users table with high ranking officer titles"
# random_title = ["Chief Information Officer", "Chief Financial Officer", "Senior Director, IT", "Senior Director, Marketing", "Senior Director, Business Applications", "Senior Director, User Experience & Design", "Chief Executive Officer", "Director, Product Management", "Chief Operations Officer", "VP, Corporate Development", "EVP, Market Development", "VP, Finance", "Chief Marketing Officer"]
# random_group = ["Accident Reporting-Utah", "Accident Reporting-San Diego", "Accident Reporting-Boston", "Accounting", "Accounts Payabale", "Accounts Receivable", "Backups", "Change Management", "Concur Corporate", "Concur Users", "Consumer Relations", "Issues", "Engineering-San Diego", "Engineering-Utah", "Engineering-Boston", "Executive Staff", "Inside Sales", "International", "IT", "IT Infrastructure", "IT Security", "IT Steering Committee", "Marketing", "Planning", "New Products", "Ops", "Oracle", "Outside Sales", "Packaging", "Paypal", "Payroll", "QA", "Research and Development", "Innovation", "Safety", "Sourcing", "Staff-All", "Staff-San Diego", "Staff-Utah", "Staff-Boston", "Warehouse", "Debug", "Test", "MySQL DBA", "Dynamix", "Salesforce", "Oracle-BI", "Auditing", "Customer Experience", "Human Resources", "Supply Chain", "Inventory", "Retail-West", "Retail-North", "Retail-South", "Retail-East", "Retail-International", "Oracle Sales", "Oracle Pricing", "Oracle Admin", "Process Engineer", "Product Dev", "Purchasing", "Reports", "Shipping", "System Administrator", "Tax", "User Management", "Employee", "Project Supervisor", "Store-Account", "Store-Accounting Boston", "Store-Accounting Utah", "Store-Accounting San Diego", "Store-Customer Experience", "Store-Consultant", "Store-Databases", "Store-Engineer", "Store-People and Culture", "Store-Main", "Store-Manufacturing", "Store-Payroll", "Store-Planning", "Store-Prod", "Store-Quality Assurance", "Store-Safe", "Store-Warehouse", "VPN", "BI-Warehouse", "BI-Prod", "BI-QA", "BI-Test", "BI-Sales", "BI-Function", "BI-Dashboards", "Trello-Admin", "Trello-Users", "Trello-Consultants", "Google Apps", "Microsoft Office", "MS Project", "Shoretel", "AWS", "AWS-S3", "AWS-Redshift", "Azure Active Directory Admin", "Azure Active Directory User", "Azure Cloud", "Spotify-Enterprise", "Apple Music Enterprise", "Apple iPhone Users", "Apple iPad Users", "Apple Macbook Pro Users", "Apple Macbook Air Users", "Apple Macbook Users", "Apple Mac Pro Users", "Dell Users"]
# 13.times do |index|
# 	first_name = FFaker::Name.first_name
# 	last_name = FFaker::Name.last_name
# 	# Uncomment the line below to see a return in the console of the first_name and last_name variables
# 	# puts "#{first_name} #{last_name}"
# 	user = User.create!(
# 		fname: first_name,
# 		lname: last_name,
# 		title: random_title[index - 1],
# 		email: first_name + "." + last_name + "@example.com",
# 		shoretel: FFaker::PhoneNumber.phone_number,
# 		cell: FFaker::PhoneNumber.short_phone_number,
# 		fax: FFaker::PhoneNumber.short_phone_number,
# 		group: random_group.sample(30).join(",")
# 	)
# 	# If you would like to see a return of the data that you populated in the console, uncomment the line below
# 	# puts user.inspect
# end

# # Seed the User table with random job titles without importing a CSV
# # Uncomment the puts to see "seeding users table with random titles"
# puts "seeding users with random titles"
# random_title = ["Business Development Manager", "System Administrator", "Senior Web Developer", "Junior Web Developer", "Business Analyst", "Payroll Administrator", "Human Resources Assistant", "Executive Assistant", "Recruiter", "Accountant", "IT Support Manager", "Business Intelligence Analyst", "IT Project Manager", "Product Owner", "Product Manager", "Analyst", "User Experience Designer", "User Interface Designer", "Business Development Analyst", "Customer Support Representative", "Marketing Manager", "Account Manager", "Accounts Payable Specialist", "Administrative Assistant", "Associate Project Manager", "Area Sales Manager", "Business Systems Analyst I", "Business Systems Analyst II", "Business Systems Architect", "Buyer", "Customer Experience Manager", "Customer Experience Lead", "Division Sales Manager", "Retail Manager", "Driver", "Facilities Assistant", "Supply Manager", "Financial Analyst", "Human Resources Generalist I", "Human Resources Generalist II", "Human Resources Coordinator", "Inventory Analyst", "Janitor", "Management Trainee", "Inventory Clerk", "Maintenance Supervisor", "Plant Manager", "Inside Sales Manager", "Outside Sales Manager", "Sanitation Manager", "Supply Chain Manager", "Sales Analytics Manager", "QA Manager", "Project Management Manager", "Engineering Manager", "Office Manager", "Manufacturing Coordinator", "Manufacturing Worker", "Manufacturing Operator", "Materials Manager", "Materials Planner", "Mechanic", "Office Administrator", "Personal Assistant", "Project Engineering Manager", "R&D Assistant", "R&D Coordinator", "R&D Product Manager", "Innovation Manager", "Innovation Product Manager", "Innovation Project Manager", "Receptionist", "Regional Sales Manager", "Training Coordinator", "Senior Training Coordintator", "Spokerperson", "PR Manager", "Welder"]
# random_group = ["Accident Reporting-Utah", "Accident Reporting-San Diego", "Accident Reporting-Boston", "Accounting", "Accounts Payabale", "Accounts Receivable", "Backups", "Change Management", "Concur Corporate", "Concur Users", "Consumer Relations", "Issues", "Engineering-San Diego", "Engineering-Utah", "Engineering-Boston", "Executive Staff", "Inside Sales", "International", "IT", "IT Infrastructure", "IT Security", "IT Steering Committee", "Marketing", "Planning", "New Products", "Ops", "Oracle", "Outside Sales", "Packaging", "Paypal", "Payroll", "QA", "Research and Development", "Innovation", "Safety", "Sourcing", "Staff-All", "Staff-San Diego", "Staff-Utah", "Staff-Boston", "Warehouse", "Debug", "Test", "MySQL DBA", "Dynamix", "Salesforce", "Oracle-BI", "Auditing", "Customer Experience", "Human Resources", "Supply Chain", "Inventory", "Retail-West", "Retail-North", "Retail-South", "Retail-East", "Retail-International", "Oracle Sales", "Oracle Pricing", "Oracle Admin", "Process Engineer", "Product Dev", "Purchasing", "Reports", "Shipping", "System Administrator", "Tax", "User Management", "Employee", "Project Supervisor", "Store-Account", "Store-Accounting Boston", "Store-Accounting Utah", "Store-Accounting San Diego", "Store-Customer Experience", "Store-Consultant", "Store-Databases", "Store-Engineer", "Store-People and Culture", "Store-Main", "Store-Manufacturing", "Store-Payroll", "Store-Planning", "Store-Prod", "Store-Quality Assurance", "Store-Safe", "Store-Warehouse", "VPN", "BI-Warehouse", "BI-Prod", "BI-QA", "BI-Test", "BI-Sales", "BI-Function", "BI-Dashboards", "Trello-Admin", "Trello-Users", "Trello-Consultants", "Google Apps", "Microsoft Office", "MS Project", "Shoretel", "AWS", "AWS-S3", "AWS-Redshift", "Azure Active Directory Admin", "Azure Active Directory User", "Azure Cloud", "Spotify-Enterprise", "Apply Music Enterprise", "Apply iPhone Users", "Apple iPad Users", "Apply Macbook Pro Users", "Apply Macbook Air Users", "Apple Macbook Users", "Apple Mac Pro Users", "Dell Users"]
# 1487.times do
# 	first_name = FFaker::Name.first_name
# 	last_name = FFaker::Name.last_name
# 	user = User.create!(
# 		fname: first_name,
# 		lname: last_name,
# 		title: random_title.sample,
# 		email: first_name + "." + last_name + "@example.com",
# 		shoretel: FFaker::PhoneNumber.phone_number,
# 		cell: FFaker::PhoneNumber.short_phone_number,
# 		fax: FFaker::PhoneNumber.short_phone_number,
# 		group: random_group.sample(30).join(",")
# 	)
# 	# If you would like to see a return of the data that you populated, uncomment the line below
# 	# puts user.inspect
# end

# Read a CSV file that contains user table data
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'UsersMembers.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
# 	t = User.new
# 	t.name = row['Name']
# 	t.title = row['Job']
# 	t.email = row['Email']
# 	t.shoretel = row['ShoreTel']
# 	t.cell = row['Cell']
# 	t.fax = row['Fax']
# 	t.group = row['MemberOf']
# 	t.save
# 	puts "#{t.name} saved"
# end
# puts "There are now #{User.count} rows in the User table"

# Read a CSV file that contains ALL job title data
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'Jobs.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
# 	t = Job.new
# 	t.title = row['Job']
# 	t.save
# 	puts "#{t.title} saved"
# end
# puts "There are now #{Job.count} rows in the Job table"

# Read a CSV file that contains ALL group data
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'Groups.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
# 	t = Group.new
# 	t.group = row['Group']
# 	t.save
# 	puts "#{t.group} saved"
# end

# puts "There are now #{Group.count} rows in the Groups table"
