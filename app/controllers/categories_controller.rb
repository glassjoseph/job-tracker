class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "You created Category #{@category.title}"

      redirect_to categories_path
    else
      flash[:failure] = "Category must have a unique name"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    #Remember, category_params is only when you're limiting a form. When you're grabbing it yourself, there is no 'category' hash
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)

    redirect_to categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    flash[:success] = "You deleted Category #{@category.title}"
    @category.destroy
    redirect_to categories_path
    #why was I getting errors when I rendered to :index?
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end

end
