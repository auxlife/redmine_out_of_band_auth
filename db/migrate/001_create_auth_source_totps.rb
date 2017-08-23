class CreateAuthSourceTotps < ActiveRecord::Migration
  def change
    create_table :auth_source_totps do |t|
      t.string :user_id, index: true
      t.string :auth_secret
	  t.string :uri
    end
  end
end
