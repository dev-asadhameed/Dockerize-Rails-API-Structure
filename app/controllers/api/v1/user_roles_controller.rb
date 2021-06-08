# frozen_string_literal: true

module Api
  module V1
    class UserRolesController < BaseController
      actions :create, :index, :show, :update

      private

      def permitted_params
        params.permit(:user_id, :role_id)
      end
    end
  end
end
