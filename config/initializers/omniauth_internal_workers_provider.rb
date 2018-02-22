# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Omniauth Strategy for Internal workers
    class InternalWorkers < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'internal_workers'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
             site: ENV.fetch('OAUTH_URI'),
             authorize_url: ENV.fetch('OAUTH_AUTHORIZE_URL')

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['id'] }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/userinfo').parsed
      end
    end
  end
end
