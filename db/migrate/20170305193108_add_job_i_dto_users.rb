class AddJobIDtoUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
	  	t.rename :job, :title
	  	t.column :job_id, :integer
		end
  end
end
