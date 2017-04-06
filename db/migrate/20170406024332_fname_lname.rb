class FnameLname < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
	  	t.rename :name, :fname
	  	t.column :lname, :string
		end
  end
end
