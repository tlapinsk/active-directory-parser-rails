class WelcomeController < ApplicationController
  $LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"
  require 'csv'
  require 'axlsx'
  require 'FFaker'
  require 'date'

  def index
  end

  # Import function
  def import
  	ad_upload(params[:file])
  	redirect_to root_url, notice: "Active Directory Data imported!"
  end

  # Function to map all imported data to the correct tables
  def ad_upload(file)
    csv_text = File.read(file.path)
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      next if (row['Name'].nil? || row['Job'].nil?)

      # Find or create job for user
      job = Job.find_or_create_by(title: row['Job'])
      # puts "found job #{job.inspect}"

      # Find or initialize user
      user = User.find_or_initialize_by(name: row['Name'])
      # t.name = row['Name']
      user.title = row['Job']
      user.email = row['Email']
      user.shoretel = row['ShoreTel']
      user.cell = row['Cell']
      user.fax = row['Fax']
      user.group = row['MemberOf']
      user.job_id = job.id if !job.nil?
      user.save!
      puts "#{user.name} saved"

      next if (row['MemberOf'].nil?)
      members = user.group.split(";")
      members.each { |m|
        group = Group.find_or_create_by(group: m)
        group_user = GroupsUser.find_or_create_by(user_id: user.id, group_id: group.id)
      }
    end
  end

  # Report function. Points to two separate functions for CSV and Excel
  def report
  	if params[:output_format] == "CSV"
  		export_data_csv
  	else params[:output_format] == "Excel"
  		export_data_excel
  	redirect_to root_url, notice: "Report created!"
  	end
  end

  # Export as Excel file function
  def export_data_excel
  	package = Axlsx::Package.new
  	workbook = package.workbook
  	jobs = Job.all.order(:title).uniq
  	jobs_join = jobs.joins("JOIN users u ON u.job_id = jobs.id")

  	workbook.add_worksheet(name: "Sheet 1") do |sheet|
  		sheet.add_row ["Job (Long)","AD","Email","ShoreTel","Cell","Fax","Desktop","Laptop","List of Members"] 
  	end
  	package.serialize("Basic.xlsx")

  	# Increment an integer (index) for sheet[1,0]
  	# sheet1 do (excel)
  	# 	# this is where you increment rows
			# jobs.each do |j|
   #  	emails = jobs_join.where("email IS NOT NULL AND jobs.id = #{j.id}")
   #  	pop_email = emails.count > 0 ? 'x' : ' '
   #  	shoretel = jobs_join.where("shoretel IS NOT NULL AND jobs.id = #{j.id}")
   #  	pop_shoretel = shoretel.count > 0 ? 'x' : ' '
   #  	cell = jobs_join.where("cell IS NOT NULL AND jobs.id = #{j.id}")
   #  	pop_cell = cell.count > 0 ? 'x' : ' '
   #  	fax = jobs_join.where("fax IS NOT NULL AND jobs.id = #{j.id}")
   #  	pop_fax = fax.count > 0 ? 'x' : ' '
   #  	job_users = User.where("`group` IS NOT NULL AND jobs.id = #{j.id}")

   #  	# Find the distinct groups for all users with this job_id
			# sql = "SELECT DISTINCT(g.`group`) from groups g join groups_users gu on gu.group_id=g.id join users u on gu.user_id=u.id and u.job_id=#{j.id}"
			# groups = ActiveRecord::Base.connection.execute(sql)
			# # Returning array of hashes
			# # "[{\"group\"=>\"Concur Business Meals\", 0=>\"Concur Business Meals\"}, {\"group\"=>\"Goals Training Sessions\", 0=>\"Goals Training Sessions\"}, {\"group\"=>\"GoogleAppsEA\", 0=>\"GoogleAppsEA\"}, {\"group\"=>\"Concur Users\", 0=>\"Concur Users\"}, {\"group\"=>\"TurnLink User Group\", 0=>\"TurnLink User Group\"}, {\"group\"=>\"Store-Outside Sales\", 0=>\"Store-Outside Sales\"}, {\"group\"=>\"Store-Sales Mailing List Database RW\", 0=>\"Store-Sales Mailing List Database RW\"}, {\"group\"=>\"Store-Accounting MCB Approvals RW\", 0=>\"Store-Accounting MCB Approvals RW\"}, {\"group\"=>\"Outside Sales\", 0=>\"Outside Sales\"}, {\"group\"=>\"Staff-Remote\", 0=>\"Staff-Remote\"}, {\"group\"=>\"Store-Sales\", 0=>\"Store-Sales\"}, {\"group\"=>\"GoogleApps\", 0=>\"GoogleApps\"}]" 
			# pop_groups = groups.map(&:values).flatten.uniq #exercise for the reader. Array of group part of the hash to comma separated string

   #    excel << [j.title, 'x', pop_email, pop_shoretel, pop_cell, pop_fax, pop_groups]       
   #    # How puts line break here
   #  end
  end

  # Export as CSV function
  def export_data_csv
  jobs = Job.all.order(:title).uniq
  jobs_join = jobs.joins("JOIN users u ON u.job_id = jobs.id")
  header = ["Job (Long)","AD","Email","ShoreTel","Cell","Fax","Desktop","Laptop","List of Members"]
  # date = Time.now
  date = Date.today.to_s
  file = "PersonaTemplate-#{date}.csv"
  CSV.open(file, "w") do |csv|
    csv << header
    jobs.each do |j|
    	emails = jobs_join.where("email IS NOT NULL AND jobs.id = #{j.id}")
    	pop_email = emails.count > 0 ? 'x' : ' '
    	shoretel = jobs_join.where("shoretel IS NOT NULL AND jobs.id = #{j.id}")
    	pop_shoretel = shoretel.count > 0 ? 'x' : ' '
    	cell = jobs_join.where("cell IS NOT NULL AND jobs.id = #{j.id}")
    	pop_cell = cell.count > 0 ? 'x' : ' '
    	fax = jobs_join.where("fax IS NOT NULL AND jobs.id = #{j.id}")
    	pop_fax = fax.count > 0 ? 'x' : ' '
    	job_users = User.where("`group` IS NOT NULL AND jobs.id = #{j.id}")

    	# Find the distinct groups for all users with this job_id
			sql = "SELECT DISTINCT(g.`group`) from groups g join groups_users gu on gu.group_id=g.id join users u on gu.user_id=u.id and u.job_id=#{j.id}"
			groups = ActiveRecord::Base.connection.execute(sql)
			# Returning array of hashes
			# "[{\"group\"=>\"Concur Business Meals\", 0=>\"Concur Business Meals\"}, {\"group\"=>\"Goals Training Sessions\", 0=>\"Goals Training Sessions\"}, {\"group\"=>\"GoogleAppsEA\", 0=>\"GoogleAppsEA\"}, {\"group\"=>\"Concur Users\", 0=>\"Concur Users\"}, {\"group\"=>\"TurnLink User Group\", 0=>\"TurnLink User Group\"}, {\"group\"=>\"Store-Outside Sales\", 0=>\"Store-Outside Sales\"}, {\"group\"=>\"Store-Sales Mailing List Database RW\", 0=>\"Store-Sales Mailing List Database RW\"}, {\"group\"=>\"Store-Accounting MCB Approvals RW\", 0=>\"Store-Accounting MCB Approvals RW\"}, {\"group\"=>\"Outside Sales\", 0=>\"Outside Sales\"}, {\"group\"=>\"Staff-Remote\", 0=>\"Staff-Remote\"}, {\"group\"=>\"Store-Sales\", 0=>\"Store-Sales\"}, {\"group\"=>\"GoogleApps\", 0=>\"GoogleApps\"}]" 
			pop_groups = groups.map(&:values).flatten.uniq #exercise for the reader. Array of group part of the hash to comma separated string

      csv << [j.title, 'x', pop_email, pop_shoretel, pop_cell, pop_fax, pop_groups]       
      # How puts line break here
      end
    end
  end

  def testcsv
    if params[:output_format] == "Test_CSV"
      export_test_data_csv
    else 
      puts "Middle Out"
    redirect_to root_url, notice: "Test report created!"
    end
  end

  def export_test_data_csv
    header = ["Name","Job","Email","ShoreTel","Cell","Fax","MemberOf"]
    high_ranking = ["Chief Information Officer", "Chief Financial Officer", "Senior Director, IT", "Senior Director, Marketing", "Senior Director, Business Applications", "Senior Director, User Experience & Design", "Chief Executive Officer", "Director, Product Management", "Chief Operations Officer", "VP, Corporate Development", "EVP, Market Development", "VP, Finance", "Chief Marketing Officer"]
    plebs = ["Business Development Manager", "System Administrator", "Senior Web Developer", "Junior Web Developer", "Business Analyst", "Payroll Administrator", "Human Resources Assistant", "Executive Assistant", "Recruiter", "Accountant", "IT Support Manager", "Business Intelligence Analyst", "IT Project Manager", "Product Owner", "Product Manager", "Analyst", "User Experience Designer", "User Interface Designer", "Business Development Analyst", "Customer Support Representative", "Marketing Manager", "Account Manager", "Accounts Payable Specialist", "Administrative Assistant", "Associate Project Manager", "Area Sales Manager", "Business Systems Analyst I", "Business Systems Analyst II", "Business Systems Architect", "Buyer", "Customer Experience Manager", "Customer Experience Lead", "Division Sales Manager", "Retail Manager", "Driver", "Facilities Assistant", "Supply Manager", "Financial Analyst", "Human Resources Generalist I", "Human Resources Generalist II", "Human Resources Coordinator", "Inventory Analyst", "Janitor", "Management Trainee", "Inventory Clerk", "Maintenance Supervisor", "Plant Manager", "Inside Sales Manager", "Outside Sales Manager", "Sanitation Manager", "Supply Chain Manager", "Sales Analytics Manager", "QA Manager", "Project Management Manager", "Engineering Manager", "Office Manager", "Manufacturing Coordinator", "Manufacturing Worker", "Manufacturing Operator", "Materials Manager", "Materials Planner", "Mechanic", "Office Administrator", "Personal Assistant", "Project Engineering Manager", "R&D Assistant", "R&D Coordinator", "R&D Product Manager", "Innovation Manager", "Innovation Product Manager", "Innovation Project Manager", "Receptionist", "Regional Sales Manager", "Training Coordinator", "Senior Training Coordintator", "Spokerperson", "PR Manager", "Welder"]
    groups = ["Accident Reporting-Utah", "Accident Reporting-San Diego", "Accident Reporting-Boston", "Accounting", "Accounts Payabale", "Accounts Receivable", "Backups", "Change Management", "Concur Corporate", "Concur Users", "Consumer Relations", "Issues", "Engineering-San Diego", "Engineering-Utah", "Engineering-Boston", "Executive Staff", "Inside Sales", "International", "IT", "IT Infrastructure", "IT Security", "IT Steering Committee", "Marketing", "Planning", "New Products", "Ops", "Oracle", "Outside Sales", "Packaging", "Paypal", "Payroll", "QA", "Research and Development", "Innovation", "Safety", "Sourcing", "Staff-All", "Staff-San Diego", "Staff-Utah", "Staff-Boston", "Warehouse", "Debug", "Test", "MySQL DBA", "Dynamix", "Salesforce", "Oracle-BI", "Auditing", "Customer Experience", "Human Resources", "Supply Chain", "Inventory", "Retail-West", "Retail-North", "Retail-South", "Retail-East", "Retail-International", "Oracle Sales", "Oracle Pricing", "Oracle Admin", "Process Engineer", "Product Dev", "Purchasing", "Reports", "Shipping", "System Administrator", "Tax", "User Management", "Employee", "Project Supervisor", "Store-Account", "Store-Accounting Boston", "Store-Accounting Utah", "Store-Accounting San Diego", "Store-Customer Experience", "Store-Consultant", "Store-Databases", "Store-Engineer", "Store-People and Culture", "Store-Main", "Store-Manufacturing", "Store-Payroll", "Store-Planning", "Store-Prod", "Store-Quality Assurance", "Store-Safe", "Store-Warehouse", "VPN", "BI-Warehouse", "BI-Prod", "BI-QA", "BI-Test", "BI-Sales", "BI-Function", "BI-Dashboards", "Trello-Admin", "Trello-Users", "Trello-Consultants", "Google Apps", "Microsoft Office", "MS Project", "Shoretel", "AWS", "AWS-S3", "AWS-Redshift", "Azure Active Directory Admin", "Azure Active Directory User", "Azure Cloud", "Spotify-Enterprise", "Apple Music Enterprise", "Apple iPhone Users", "Apple iPad Users", "Apple Macbook Pro Users", "Apple Macbook Air Users", "Apple Macbook Users", "Apple Mac Pro Users", "Dell Users"]
    date = Date.today.to_s
    file = "Test-CSV-#{date}.csv"
    CSV.open(file, "w") do |csv|
      csv << header
      high_ranking.each do |h|
        fname = FFaker::Name.first_name
        lname = FFaker::Name.last_name
        name = fname + " " + lname
        # plebs.each do |p|
        email = fname + "." + lname + "@example.com"
        shoretel = FFaker::PhoneNumber.short_phone_number
        cell = FFaker::PhoneNumber.short_phone_number
        fax = FFaker::PhoneNumber.short_phone_number
        memberof = groups.sample(30)
        csv << [name, h, email, shoretel, cell, fax, memberof]
      end
    end
  end
end
