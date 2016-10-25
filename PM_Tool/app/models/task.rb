class Task < ApplicationRecord
  belongs_to :project
  before_validation :set_default

  private

  def set_default
    self.status ||= false
  end
end
