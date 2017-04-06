class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :fname
      t.string :lname
    	t.string :title
    	t.string :email
    	t.string :shoretel
    	t.string :cell
    	t.string :fax
    	t.string :group
      t.integer :job_id

      t.timestamps
    end
  end
end
