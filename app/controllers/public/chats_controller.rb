class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  def show
    @user = User.find(params[:id])
    @rooms = current_user.user_rooms.pluck(:room_id)
    # @user_rooms = UserRoom.find_by(user_id: @user.id, room_id: @rooms)
    @user_rooms = UserRoom.where(user_id: @user.id, room_id: @rooms).first

    unless @user_rooms.nil?
      @room = @user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)

  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    if @chat.save
      redirect_back fallback_location: root_path, notice: 'Message sent.'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to send message.'
    end
  end

  def index
  end

  def destroy
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id, )
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
  end
end

