class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!



end