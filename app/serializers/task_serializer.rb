class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :visibility

  belongs_to :user
end
