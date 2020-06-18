class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friend_request = current_user.friend_requests
    @pending_request = current_user.pending_friend
  end

  def create
    @user = User.find(params[:user_id])

    if @user != current_user
      current_user.friendships.create(friend: @user)

      redirect_to request.referrer, notice: 'Friend request succesffuly sent'
    
    end
  end

  def update
    @friendship = Friendship.find(params[:id])

    if params[:status] == '1'
      @friendship.update(status: true)
      current_user.friendships.create(friend: @friendship.user, status: true)
    else
      @friendship.destroy

    end
    redirect_to request.referrer
  end
end
