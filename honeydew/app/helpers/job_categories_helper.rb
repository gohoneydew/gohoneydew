module JobCategoriesHelper
  def icon(job_category)
    case job_category
      when "Dog Walking"
        "fa-child"
      when "Animals"
        "fa-paw"
      when "Indoor - Home"
        "fa-home"
      when "Outdoor - Home"
        "fa-tree"
      when "Food"
        "fa-beer"
      when "Miscellaneous"
        "fa-cog"
      when "Technical"
        "fa-code-fork"
      when "Auto"
        "fa-car"
      else
        "fa-dashboard"
    end
  end
end
