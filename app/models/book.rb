class Book < ApplicationRecord
  belongs_to :author

  validate :release_date_in_past

  private

  def release_date_in_past
    if release_date.present? && release_date > Date.today
      errors.add(:release_date, "must be in the past")
    end
  end
end