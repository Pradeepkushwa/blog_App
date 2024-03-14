class PostSerializer < ActiveModel::Serializer
    attributes :id, :user_id,:title, :content,:publication_date
end
