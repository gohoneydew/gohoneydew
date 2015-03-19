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
  def task_price(wallet,price)
    if wallet.id == current_user.id
      '$' +  number_with_precision(price, :precision => 2)
    else
      '$' +  number_with_precision(price * 0.85, :precision => 2)
    end
  end

  def rating_percentage(rating_required)
    (rating_required.to_f / 5) * 100
  end
  def task_status(status)
    if status == "open"
      'text-success'
    elsif status == "pending"
      'text-warning'
    elsif status == "closed"
      'text-danger'
    end
  end
  def ratingColor(task)
    if task.rating_required <= task.average_rating(current_user)
      'progress-bar-success'
    else
      'progress-bar-danger'
    end
  end

end
