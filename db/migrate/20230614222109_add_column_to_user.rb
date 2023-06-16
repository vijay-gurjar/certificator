class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp_created_at, :date
  end
end
