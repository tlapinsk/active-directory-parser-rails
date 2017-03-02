class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :job
    	t.string :email
    	t.integer :shoretel, limit: 8
    	t.integer :cell, limit: 8
    	t.integer :fax, limit: 8
    	t.string :group

      t.timestamps
    end
  end
end
