class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = current_user.categories.includes(:expenses)
  end

  def show
    @category = Category.includes(:expenses).find(params[:id])
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Group was successfully created.'
    else
      flash.now[:alert] = 'Group could not be created.'
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_path, notice: 'Category deleted successfully.' }
      format.json { head :no_content }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
