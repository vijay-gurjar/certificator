class AddVidhanSabhaToCertificate < ActiveRecord::Migration[7.0]
  def change
    add_column :certificates, :vidhan_sabha, :string
  end
end
