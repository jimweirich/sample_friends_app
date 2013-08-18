class FriendshipsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @friendship = Friendship.new(user: @user)
  end

  def create
    @user = User.find(params[:user_id])
    friend_name = params[:friendship][:friend]
    @friend = User.find_by_name(friend_name)
    if @friend.nil?
      flash.now[:alert] = "Can't find friend '#{friend_name}'"
      @friendship = Friendship.new
      render :new
    elsif @user.add_friend(@friend)
      redirect_to user_path(@user), notice: "Added #{@friend.name} as a friend to #{@user.name}"
    else
      flash.now[:alert] = "Can't save friendship"
      @friendship = Friendship.new
      render :new
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    user = friendship.user
    friend = friendship.friend
    friendship.delete
    redirect_to user_path(user), notice: "#{friend.name} is no longer a friend of #{user.name}'s"
  end
end
