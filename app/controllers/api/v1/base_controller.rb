module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :authenticate_admin!
    end
  end
end
