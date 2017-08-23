class CreateAuthSourceTotps < ActiveRecord::Migration
  def change
    create_table :auth_source_totp do |t|
      t.integer :user_id, index: true
      t.string :auth_secret
    end
  end
end
