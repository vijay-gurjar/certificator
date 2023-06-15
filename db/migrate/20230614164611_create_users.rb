class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :phone_number
      t.string :otp

      t.timestamps
    end
  end
end
