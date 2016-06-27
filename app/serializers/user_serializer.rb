class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :task_ids
end