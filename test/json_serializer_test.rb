require 'cutest'
require_relative '../lib/json_serializer'

Post = Struct.new :id, :title

class PostPresenter < JsonSerializer
  attribute :id
  attribute :title
end

test 'converts attributes hash to json' do
  post = Post.new 1, 'tsunami'
  presenter = PostPresenter.new post

  result = post.to_h.to_json

  assert_equal result, presenter.to_json
end

class PostWithRootPresenter < JsonSerializer
  root :post

  attribute :id
  attribute :title
end

test 'defines root' do
  post = Post.new 1, 'tsunami'
  presenter = PostWithRootPresenter.new post

  result = { post: post.to_h }.to_json

  assert_equal result, presenter.to_json
end
