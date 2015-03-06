module TasksHelper
  def chat_bubble_position(note)
    if note.sender_id == current_user.id
      "chat-bubble chat-bubble-left"
    else
      "chat-bubble chat-bubble-right"

    end
  end
  def avatar_position(note)
      if note.sender_id == current_user.id
        "img-circle chat-bubble-avatar chat-bubble-avatar-left"
      else
        "img-circle chat-bubble-avatar chat-bubble-avatar-right"

      end
  end
  def task_status_helper(status)
    if status == "open"
      'fa fa-lg fa-folder-open-o'
    elsif status == "pending"
      'fa fa-gavel'
    end
  end
  def recipient_id(task)
    if task.wallet_id == current_user.id
        task.runner_id
    elsif task.runner_id == current_user.id
        task.wallet_id
    end
  end

end
