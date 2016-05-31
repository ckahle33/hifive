class UserFilesController < ApplicationController

  def index
  end

  def new
    @user_file = UserFile.new
  end

  def edit
  end

  def show
    @user_file = UserFile.find(params[:id])
  end

  def create
    @user_file = UserFile.new(file_params)

    respond_to do |format|
      if @user_file.save
        format.html { redirect_to @user_file, notice: "#{@user_file.name} was successfully created." }
        format.json { render :show, status: :created, location: @user_file }
      else
        format.html { render :new }
        format.json { render json: @user_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def file_params
    params.require(:user_file).permit(:name, :path)
  end

end
