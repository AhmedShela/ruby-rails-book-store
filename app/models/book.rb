class Book < ApplicationRecord
  belongs_to :author

  validates :name, uniqueness: true
  validate :release_date_in_past

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['Book Name', 'Release Date', 'Author Name']
      all.each do |book|
        csv << [book.name, book.release_date, book.author.name]
      end
    end
  end

  def self.to_xlsx
    package = Axlsx::Package.new
    workbook = package.workbook
    workbook.add_worksheet(name: 'Books') do |sheet|
      sheet.add_row(['Book Name', 'Release Date', 'Author Name'])
      all.each do |book|
        sheet.add_row([book.name, book.release_date, book.author.name])
      end
    end
    package.to_stream.read
  end

  private

  def release_date_in_past
    if release_date.present? && release_date > Date.today
      errors.add(:release_date, "must be in the past")
    end
  end
end