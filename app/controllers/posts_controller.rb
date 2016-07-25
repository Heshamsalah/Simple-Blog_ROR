class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #This if statement is used to handle filtering by Tags, Useremail(Author),
    #or Tilte
    if params[:tag] #this one is for tag filtering
      @posts = Post.tagged_with(params[:tag]).order("created_at DESC")
    elsif params[:search] #this one is for title search keywords
      @posts = Post.where("title LIKE :t", {t: "%#{params[:search].upcase}%"})
    elsif params[:user_email] #this one is for finding user email related to the
                              # post to retrieve all his posts
      user_id = User.find_by(email: params[:user_email]).id
      @posts = Post.where(user_id: user_id)
    else
      @posts = Post.all.order("created_at DESC")
    end
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.title = @post.title.upcase
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    user_id = current_user.id
    if (current_user.id == @post.user_id)
      @post.destroy
      redirect_to root_path
    else
      flash[:alert] = "Your are not the Post Owner, You can't Delete it"
      render 'show'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :tag_list, :picture)
    end

    def get_post
      @post = Post.find(params[:id])
    end
end
