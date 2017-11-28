class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale]  if params[:locale].present?
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

end
