class Api::V1::CommentsController < ApiController
  def index
    comments = Post.find(params[:post][:id]).comments

    if !comments.empty?
      render json: comments, status: 200
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def show
    comment = Comment.find(params[:id])

    render json: comment, status: 200
  end

  def create
    comment = Post.find(params[:post][:id]).comment.new(comment_params)

    if comment.save
      render json: { comment: "#{comment.id}", created: "Yes"}, status: 200
    end
  end

  def update
    comment = Comment.find(params[:id])

    if authorized?(comment) && comment.update(comment_params)
      render json: { comment: "#{comment.id}", updated: "Yes"}, status: 200
    end
  end

  def destroy
    comment = Comment.find(params[:id])

    if authorized?(comment) && comment.destroy
      render json: { comment: "#{comment.id}", destroyed: "Yes"}, status: 200
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorized?(comment)
    current_user == comment.user
  end
end
