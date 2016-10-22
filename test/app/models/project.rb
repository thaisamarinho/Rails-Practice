class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  validate :valid_deadline

  def valid_deadline
    if self.due_date < Date.today
      errors.add(:due_date, "is invalid.")
    end
  end



end
