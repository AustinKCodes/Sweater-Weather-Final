class UsersSerializer
  include JSONAPI::Serializer
  set_type :users
  set_id :id
  attributes :email, :api_key
end