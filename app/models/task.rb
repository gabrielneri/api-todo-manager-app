class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, :description, :visibility, presence: true

  enum status: { not_finished: 0, finished: 1 }
  enum visibility: { public_task: 0, private_task: 1 }

  scope :public_tasks, -> { where(visibility: :public_task) }
  scope :private_tasks, -> { where(visibility: :private_task )}

end
