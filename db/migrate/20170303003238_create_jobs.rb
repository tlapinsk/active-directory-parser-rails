class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
    	t.string :job

      t.timestamps
    end
  end
end
