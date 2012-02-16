class AccountsController < ApplicationController
  include AccountsHelper

  before_filter :require_user, :except => [:login, :process_login, :new, :create]
  before_filter :load_account, :except => [:login, :process_login, :new, :create]
  
  # GET /account/login
  def login
    error, notice = flash[:error], flash[:notice]
    reset_session
    flash[:error], flash[:notice] = error, notice
    @account = Account.new
  end

  # POST /account/process_login
  def process_login
    @account = Account.find_by_username_and_password params[:account][:username], encrypt(params[:account][:password])

    if @account
      reset_session
      session[:user_id] = @account.id
      redirect_to player_path, notice: 'Successfully logged in.'
    else
      flash[:error] = 'Invalid username/password'
      redirect_to login_account_path
    end
  end

  # GET /account/logout
  def logout
    reset_session
    redirect_to login_account_path, notice: 'Successfully logged out'
  end

  # GET /account
  def show
  end

  # GET /account/new
  def new
    @account = Account.new
    @player  = Player.new
  end

  # GET /account/edit
  def edit
  end

  # POST /account
  def create
    @account = Account.new params[:account]
    @player  = @account.build_player params[:player]

    if @account.save
      if @player.save
        redirect_to login_account_path, notice: 'Account was successfully created.'
      else
        @account.destroy
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  # DELETE /account
  def destroy
    @account.destroy
    redirect_to login_account_path, notice: 'Account deleted!'
  end

  # PUT /account
  def update
    if @account.update_attributes params[:account]
      redirect_to edit_account_path, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end
end
