class MessagesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @message = @user.messages.new
  end

  def create
    @user = User.find(params[:user_id])
    @message = @user.messages.new
    @message.body = params[:message][:body]
    @message.addressed_to(params[:to])
    if @message.save
      redirect_to user_path(@user), notice: "Message Created"
    else
      render :new
    end
  end
end
