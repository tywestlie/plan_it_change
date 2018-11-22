class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id, :created_at, :updated_at
end
