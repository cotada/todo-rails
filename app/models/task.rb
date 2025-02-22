class Task < ApplicationRecord
  validates :title, presence: true
  validates :priority, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10,
    allow_nil: true
  }

  before_save :ensure_priority_is_integer

  private

  def ensure_priority_is_integer
    self.priority = priority.to_i if priority.present?
  end
end
