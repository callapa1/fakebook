class InvitationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

  def create
    @user = User.find(params[:user])
    @invitation = current_user.send_invitation(@user)

    if @invitation.save
      redirect_to friends_path
    else
      
    end
  end

  def update
    @invitation = Invitation.find(params[:id])
    current_user.confirm_invitation(@invitation)
    if @invitation.update(confirmed: true)
      redirect_to friends_path
    else
      raise @invitation.inspect
    end
  end

  def destroy
    @invitation = Invitation.find_invitation(current_user, params[:id].to_i)
    @invitation.first.delete
    redirect_to friends_path
  end

end