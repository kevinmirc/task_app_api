class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id, :user_ids
end