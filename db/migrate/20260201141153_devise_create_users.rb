class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email
      t.string :encrypted_password

      ## Phone and OTP authentication
      t.string :phone_number, null: false
      t.string :otp_secret_key
      t.datetime :otp_sent_at
      t.integer :failed_otp_attempts, default: 0
      t.datetime :otp_locked_until

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false
      t.datetime :locked_at
      t.string   :unlock_token

      ## Additional fields
      t.string :name
      t.boolean :admin, default: false
      t.boolean :phone_verified, default: false
      t.boolean :email_verified, default: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :phone_number,         unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :otp_secret_key,       unique: true
  end
end