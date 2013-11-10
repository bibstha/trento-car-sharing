class TemplatesController < ApplicationController
  # TODO security issue, can see secret files as well
  # Seems like security right now is being taken care by rails
  def show
    render partial: params[:template_name]
  end
end
