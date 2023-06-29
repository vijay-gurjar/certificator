module AdminHelper
  require 'csv'

  def generate_download_file(data)
    file = Tempfile.new('data')
    CSV.open(file.path, 'w') do |csv|
      csv << data.first.attributes.keys # Add headers dynamically based on column names

      data.each do |item|
        csv << item.attributes.values # Add data rows dynamically based on column values
      end
    end
    file
  end

  def generate_report_data(data)
    file = Tempfile.new('data')
    CSV.open(file.path, 'w') do |csv|
      csv << ["#{params[:type].capitalize} Names", "Certificate Downloads"] # Add headers

      data.each do |key, value|
        csv << [key, value] # Add data rows
      end
    end
    file
  end

end
