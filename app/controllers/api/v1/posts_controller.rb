class Api::V1::PostsController < ApiController
  before_action :authenticate_user, only: [:create, :destroy, :update]

  def index
    posts = Post.find_all_posts_by_location(params[:city], params[:state])

    render json: posts, status: 200
  end

  def show
    post = Post.find(params[:id])

    render json: post, status: 200
  end

  def create
    post = current_user.post.new(post_params)

    if post.save
      render json: { created: "Yes" }, status: 200
    end
  end

  def update
    post = Post.find(params[:id])

    if authorized?(post) && post.update(post_params)
      render json: { post: "#{post.id}", updated: "Yes" }, status: 200
    end
  end

  def destroy
    post = Post.find(params[:id])

    if authorized?(post) && post.destroy
      render json: { post: "#{post.id}", destroyed: "Yes"}, status: 200
    end
  end

  private

  def post_params
    params.require(post).permit(:body)
  end

  def authorized?(post)
    post.user == current_user
  end
end
