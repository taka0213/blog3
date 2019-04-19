class BlogsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @blogs =Blog.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.create( title: blog_params[:title], image: blog_params[:image], content: blog_params[:content], user_id: current_user.id)
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.user_id == current_user.id
      @blog.destroy
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end


  def update
    @blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(blog_params)
    end
  end



  private
  def blog_params
    params.require(:blog).permit(:title, :image, :content)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


 

end
