class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Authors", :authors_path

  def new
    @author = Author.new
    add_breadcrumb "Create author", new_author_path
  end

  def index
    @authors = Author.search(params[:search]).order(:name).page(params[:page]).per(30)
  end

  def show
    @author = Author.find(params[:id])
    add_breadcrumb "Show author", @author
  end

  def edit
    @author = Author.find(params[:id])
    add_breadcrumb "Edit author", edit_author_path
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html {
          flash[:success] = "Author was successfully created."
          redirect_to @author
        }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html {
          flash[:success] = "Author was successfully updated."
          redirect_to @author
        }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Author was successfully destroyed."
        redirect_to authors_url
      }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Author.destroy(params[:authors])

    respond_to do |format|
      format.html { redirect_to authors_path }
      format.json { head :no_content }
    end
  end

private
  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
