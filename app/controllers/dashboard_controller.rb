class DashboardController < ApplicationController
  before_action :auth_check
  layout 'dashboard'

  def index
  end

  def editor
  end
end
