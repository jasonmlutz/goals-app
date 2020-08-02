class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token
      t.boolean :activated, default: false
      t.string :activation_token
      t.boolean :admin, default: false

      t.index :email, unique: true
      t.timestamps
    end
  end
end
