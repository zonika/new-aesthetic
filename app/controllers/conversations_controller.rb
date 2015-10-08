class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]
  before_action :get_box, only: [:index]
  before_action :get_conversation, except: [:index, :empty_trash]


  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
      # this is how you grab the subject = @mailbox.inbox[0].subject
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else @box.eql? "trash"
      @conversations = @mailbox.trash
    end
  end

  def show
  end

  def reply
    @receipt = current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end
private

  def get_mailbox
      @mailbox ||= current_user.mailbox
  end

  def get_conversation
      @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end

end
