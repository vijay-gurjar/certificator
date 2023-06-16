class CreateCertificates < ActiveRecord::Migration[7.0]
  def change
    create_table :certificates do |t|
      t.string :name
      t.string :address
      t.string :zila
      t.string :lok_sabha
      t.string :state
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
