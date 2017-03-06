class WelcomeController < ApplicationController
  require 'csv'

  def index
  end

  def import
  	ad_upload(params[:file])
  	redirect_to root_url, notice: "Active Directory Data imported!"
  end

  def report
  	export_data
  	redirect_to root_url, notice: "Report created!"
  end

  def export_data
  jobs = Job.all.order(:title).uniq
  jobs_join = jobs.joins("JOIN users u ON u.job_id = jobs.id")
  header = ["Job (Long)","AD","Email","ShoreTel","Cell","Fax","Desktop","Laptop","List of Members"]
  # date = Time.now
  date = "2017-03-04"
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
end
