class DevelopersController < ApplicationController
  def show
    @developer = Developer.find_by_username!(params[:id])
    @posts = @developer.posts.order(created_at: :desc).includes(:tag)
  end

  def edit
    @developer = current_developer
  end

  def update
    @developer = current_developer
    if @developer.update(developer_params)
      redirect_to root_path, notice: 'Developer updated'
    else
      flash.now[:alert] = @developer.errors.full_messages
      render :edit
    end
  end

  private

  def developer_params
    params.require(:developer).permit :email, :username, :twitter_handle
  end
end
