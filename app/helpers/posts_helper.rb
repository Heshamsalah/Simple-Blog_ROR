module PostsHelper
  def get_post_tags(post)
    raw post.tag_list.map{ |t|
      link_to t, {controller: "posts", action: "index", tag: t} }.join(', ')
  end

  def get_post_author(post)
    link_to User.find(post.user_id).email, {controller: "posts", action: "index", user_email: User.find(post.user_id).email}
  end
end
