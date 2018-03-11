class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, flash: { success: "Category '#{@category.name}' created successfully" } }
      else
        format.html { render :new, flash: { danger: 'The category was not created' } }
      end
    end
  end

  def show
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end