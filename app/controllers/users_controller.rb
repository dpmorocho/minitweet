class UsersController < ApplicationController
	respond_to :html, :json, :xml
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy
  
	def show
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Bienvenido a MiniTweet!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		#@user = User.find(params[:id])
	end

	def update
		#@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Perfil Actualizado"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.paginate(page: params[:page])
		respond_with(@users)
	end

	def destroy
    	User.find(params[:id]).destroy
    	flash[:success] = "Usuario Borrado."
		redirect_to users_path
	end

	def following
		@title = "Siguiendo"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Seguidores"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end
	private
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_path, notice: "Identificate."
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end	
end