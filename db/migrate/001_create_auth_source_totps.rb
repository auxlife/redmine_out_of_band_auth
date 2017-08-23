class CreateAuthSourceTOTPs < ActiveRecord::Migration
  def change
    create_table :auth_source_totp do |t|
      t.integer :user_id, index: true
      t.string :auth_secret

      t.timestamps
    end
  end
end
