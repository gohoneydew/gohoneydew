module ApplicationHelper
  def title
    base_title = "RR Project - Coming Soon!!!"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def logo
    image_tag("RRMockLogo.png", :alt => "Logo Will Go Here", :class => "round")
  end
  # Everything from here is for allowing devise to use resources to log in from the homepage.
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  def link_to_image(image_path, target_link,options={})
    link_to(image_tag(image_path, :border => "0"), target_link, options)
  end

  def sortable (column, title = nil)
    title ||= column.titleize
    link_to title, params.merge(:sort => column)
  end
  def all_jobs(user)
    user.owned_jobs + user.jobs
  end
  #end of devise home page login.
end
