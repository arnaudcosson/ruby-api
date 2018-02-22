# frozen_string_literal: true

# Callback for Omniauth
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def internal_workers
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      # set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      # TODO redirect_to error_page
    end
  end

  def failure
    redirect_to root_path
  end
end
