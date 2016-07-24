class FeedsController < ApplicationController
  layout false
  def rss
    @posts = Post.all.order("created_at DESC")
  end
end
