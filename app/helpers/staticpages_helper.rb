module StaticpagesHelper
  def active?(page) # Adds active class to dashboard panel
    'current-page' if current_page?("/#{page}")
  end

  def table_hidden? # Hides index table in edit mode
    'col-hidden' if @action == 'Bewerk'
 end

  def form_hidden? # Hides form in index/create mode
    'col-hidden' if @action != 'Bewerk'
  end
end
