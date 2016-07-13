module ApplicationHelper

  # status_tag method that takes up 2 parameters, the boolean value from page.visible and the default parameters for the options hash
  # now if boolean == true or visible show the content_tag with the span class of status true and append the double quotes from within the "<span>" "</span" tags, as a placeholder for text,
  # whatever we defined inside of the options[:true_text] ||= "some string", will be outputted in the view in between the span tags
  def status_tag(boolean , options = {})
    options[:true_text] ||= ''
    options[:true_text] ||= ''
    # OR
    # options[:true_text] ||= 'true' # outputs "true" if boolean is true within span tags with the class of status true
    # options[:false_text] ||= 'false' # outputs "false" if boolean is false within span tags with the class of status false

    if boolean
      content_tag(:span, options[:true_text], :class=> "status true")
    else
        content_tag(:span, options[:false_text], :class => "status false")
    end
  end
end
