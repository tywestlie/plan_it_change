class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :created_at, :updated_at, :last_login, :first_name, :last_name
end
