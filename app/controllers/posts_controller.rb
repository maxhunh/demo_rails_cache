class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  caches_page :index

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/15
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        # TODO: write in one place
        expire_page posts_path
        expire_page post_path(@post)
        expire_page "/"
        FileUtils.rm_rf "#{page_cache_directory}/public/page"
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        # TODO: write in one place
        expire_page posts_path
        expire_page post_path(@post)
        expire_page "/"
        FileUtils.rm_rf "#{page_cache_directory}/public/page"
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      # TODO: write in one place
      expire_page posts_path
      expire_page post_path(@post)
      expire_page "/"
      FileUtils.rm_rf "#{page_cache_directory}/public/page"
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :status)
    end

    def clear_page_cahe

    end
end
