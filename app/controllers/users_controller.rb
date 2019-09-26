class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user, except: %i[create index]
  
    # GET /users
    def index
      @users = User.all
      render json: @users, status: :ok
    end
  
    # GET /users/{username}
    def show
      render json: @user, status: :ok
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        # flash[:success] = "Please confirm your email address to continue"
        redirect_to root_url
        render json: @user, status: :created
      else
        # flash[:error] = "Ooooppss, something went wrong!"
      render 'new'
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # PUT /users/{username}
    def update
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # DELETE /users/{username}
    def destroy
      @user.destroy
    end

    def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        # flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
        # Please sign in to continue."
        redirect_to signin_url
      else
        redirect_to root_url
      end
  end
  
    private
  
    def find_user
      @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end
    
    def user_params
      params.permit(
        :name, :username, :email, :password, :password_confirmation
      )
    end 
  end