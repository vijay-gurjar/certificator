class AddColumnToCertificate < ActiveRecord::Migration[7.0]
  def change
    add_column :certificates, :download_count, :integer
    add_column :certificates, :certificate_number, :string
  end
end
