# Rolemapping

Rolemapping is a web app to store, parse, and format Active Directory data.

It was built, in part, due to the limitations of Excel and multiple weeks that I would have spent consolidating Active Directory user data manually. It was also the perfect introduction to databases, reading CSV files, and [Bootstrap](https://github.com/twbs/bootstrap); all within [the Rails framework](https://github.com/rails/rails).

## Getting Started

Ruby version: 2.3.0
Rails version: 5.0.2

1. [Download the repository](https://github.com/tlapinsk/rolemapping/archive/master.zip) OR open up Terminal:

	```shell session
	$ git clone https://github.com/tlapinsk/rolemapping
	```

2. At the command prompt:

	```shell session
	$ cd rolemapping
	$ rails s
	```

3. Using a browser, go to http://localhost:3000 and you will see the application homepage.

4. Edit the application to your liking. You may find the following resources handy:
	* [AXLSX](https://github.com/randym/axlsx)
	* [FFaker](https://github.com/ffaker/ffaker)
	* [Bootstrap](https://github.com/twbs/bootstrap)

5. Visit [Configuration](#configuration) for more detailed instructions.

### System Dependencies

See [Gemfile](https://github.com/tlapinsk/rolemapping/blob/master/Gemfile) and [Gemfile.lock](https://github.com/tlapinsk/rolemapping/blob/master/Gemfile.lock).

_Note: I did not test the application on Windows, and I run the following system_

Macbook Pro (15-inch, Mid 2010)
macOS Sierra | Version 10.12.4
Memory: 8gb
Storage: 500gb Samsung SSD

## Configuration

This section provides more detailed instructions for the application, including customization.

### Customizing 'Create Test Data' Output

1. Open up `welcome_controller.rb`

2. Navigate to the `export_test_data_csv` function (last function).

The following instructions all pertain to the `export_test_data_csv` function.

**Adding additional job titles and groups**
Feel free to add additional job titles in the `high_ranking`, `low_ranking`, and `group` arrays.

There are currently 13 high ranking titles, so keep that in mind when editing the `high_ranking` array. 

**Editing CSV file name**
Edit the `file` and `date` variables to your liking.

**Total rows output**
By default there are 1500 total rows in the CSV. The first 13 are high ranking (CEO, CIO, etc.), while the remaining 1487 are low ranking (Business Analyst, Product Manager, etc.). 

Edit the total number of officers by changing the `high_ranking` or `low_ranking` arrays. OR by changing the number in the `1487.times do` loop.

**Adding additional columns**

1. Start by changing the `header` array. Add additional column headers or edit them as you prefer.

	```ruby
	header = ["Name","Job","Email","ShoreTel","Cell","Fax","Laptop","Desktop","Monitor","MemberOf"]
	```

2. Within the two loops, make sure you add the appropriate variable to match the column header.

	```ruby
	laptop_desktop_monitor = ['x', ' ']
	date = Date.today.to_s
	file = "Test_CSV_#{date}.csv"
	CSV.open(file, "w") do |csv|
		csv << header
		high_ranking.each do |h|
		  fname = FFaker::Name.first_name
		  lname = FFaker::Name.last_name
		  name = fname + " " + lname
		  email = fname.downcase + "." + lname.downcase + "@example.com"
		  shoretel = FFaker::PhoneNumber.short_phone_number
		  cell = FFaker::PhoneNumber.short_phone_number
		  fax = FFaker::PhåoneNumber.short_phone_number
		  laptop = laptop_desktop_monitor.random
		  desktop = laptop_desktop_monitor.random
		  monitor = laptop_desktop_monitor.random
		  memberof = groups.sample(30).join(";")
		  csv << [name, h, email, shoretel, cell, fax, memberof]
		end
		1487.times do 
		  fname = FFaker::Name.first_name
		  lname = FFaker::Name.last_name
		  name = fname + " " + lname
		  h = low_ranking.sample
		  email = fname.downcase + "." + lname.downcase + "@example.com"
		  shoretel = FFaker::PhoneNumber.short_phone_number
		  cell = FFaker::PhoneNumber.short_phone_number
		  fax = FFaker::PhoneNumber.short_phone_number
		  laptop = laptop_desktop_monitor.random
		  desktop = laptop_desktop_monitor.random
		  monitor = laptop_desktop_monitor.random
		  memberof = groups.sample(30).join(";")
		  csv << [name, h, email, shoretel, cell, fax, memberof]
		end
	end	
	```

3. Edit `csv << [name, h, email, shoretel, cell, fax, memberof]` to include your newly created variables.

	```ruby
	csv << [name, h, email, shoretel, cell, fax, laptop, desktop, monitor, memberof]
	```

4. BAM! You should have a new columns added to your Test Data CSV.

_Note: Check out the [FFaker documentation](https://github.com/ffaker/ffaker) to see other fake data that you can generate with the FFaker gem._

### Customizing 'Import' Function

Provides instructions for customizing the `Import Active Directory CSV File` feature.

_Note: You might want to edit the Create CSV section before customizing the 'Import' function._

**Editing the database**
Depending on your goals, you will need think through the database schema and migrations you will need to run.

Example migration:

1. Navigate to `schema.rb` and look at the User table columns.
2. Decide on extra columns you want to add and/or delete.
3. Open up Terminal and run `rails generate migration add_InsertFieldname_to_InsertTableName`
4. Add additional column names and types to the migration file (code example below).

	```ruby
	class Lastname < ActiveRecord::Migration[5.0]
	  def change
	  	change_table :users do |t|
	  		t.column :laptop, :string
	  		t.column :desktop, :string
	  		t.column :monitor, :string
	  	end
	  end
	end
	```

5. In the Terminal, run `rake db:migrate` to migrate the changes.
6. Check `schema.rb` to double check your changes.

**Editing the** `ad_upload(file)` **function**

Next, you'll have to edit `welcome_controller.rb`

1. Open up `welcome_controller.rb`
2. Navigate to the `ad_upload(file)` function.
3. Go to the following code.

	```ruby
	user.title = row['Job']
	user.email = row['Email']
	user.shoretel = row['ShoreTel']
	user.cell = row['Cell']
	user.fax = row['Fax']
	user.group = row['MemberOf']
	user.job_id = job.id if !job.nil?
	user.save!
	puts "#{user.name} saved"
	```

4. Create new `user.NEWCOLUMN = row['NEWCOLUMN']`

	```ruby
	user.title = row['Job']
	user.email = row['Email']
	user.shoretel = row['ShoreTel']
	user.cell = row['Cell']
	user.fax = row['Fax']
	user.group = row['MemberOf']
	user.laptop = row['Laptop']
	user.desktop = row['Desktop']
	user.monitor = row['Monitor']
	user.job_id = job.id if !job.nil?
	user.save!
	puts "#{user.name} saved"
	```

5. Save your project, reboot the app, and load http://localhost:3000
6. Import your new CSV and debug as necessary.
7. BOOM! You've successfully edited the database schema.

### Customizing the 'Export' function(s)

Provides instructions for customizing the `Export Report` functionality.

1. Open up `welcome_controller.rb`
2. Navigate to the `export_data_csv` function.
3. If you've made changes to the database, edit the `header` variable.

	```ruby
	header = ["Job (Long)","AD","Email","ShoreTel","Cell","Fax","Laptop","Desktop","Monitor","List of Members"]
	```

4. Edit `date` and `file` variables to your liking.

	```ruby
	date = Date.today.to_s
	file = "PersonaTemplate-#{date}.csv"
	```

5. Edit `jobs.each do |j|` loop.

	```ruby
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
		laptop = jobs_join.where("laptop IS NOT NULL AND jobs.id = #{j.id}")
		pop_laptop = laptop.count > 0 ? 'x' : ' '
		desktop = jobs_join.where("desktop IS NOT NULL AND jobs.id = #{j.id}")
		pop_desktop = desktop.count > 0 ? 'x' : ' '
		monitor = jobs_join.where("monitor IS NOT NULL AND jobs.id = #{j.id}")
		pop_monitor = monitor.count > 0 ? 'x' : ' '


		# Find the distinct groups for all users with this job_id
		sql = "SELECT DISTINCT(g.`group`) from groups g join groups_users gu on gu.group_id=g.id join users u on gu.user_id=u.id and u.job_id=#{j.id}"
		groups = ActiveRecord::Base.connection.execute(sql)
		# Returning array of hashes
		pop_groups = groups.map(&:values).flatten.uniq #exercise for the reader. Array of group part of the hash to comma separated string

		csv << [j.title, 'x', pop_email, pop_shoretel, pop_cell, pop_fax, pop_laptop, pop_desktop, pop_monitor, pop_groups]       
		end
	end
	```

6. That should do it. Debug as necessary!

_Note: The `export_data_excel` function is not working, but feel free to fix it. The [AXLSX documentation](https://github.com/randym/axlsx) should be helpful, so check it out._

If I forgot anything, please let me know. And if you have any questions, you can always email at tim.lapinskas@gmail.com.


















