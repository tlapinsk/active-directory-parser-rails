class ChangeJobtoTitleinJobs < ActiveRecord::Migration[5.0]
  def change
  	change_table :jobs do |t|
	  	t.rename :job, :title
	  	t.column :include_in_report, :boolean, default: true
		end
  end
end
