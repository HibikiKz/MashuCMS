class PagesController < ApplicationController
  def index
    render plain: "Front Page #{logged_in?}"
  end
end
