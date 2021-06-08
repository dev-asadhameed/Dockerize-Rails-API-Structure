# frozen_string_literal: true

module Api
  module V1
    class ChallengesController < BaseController
      actions :create, :index, :show, :update

      def collection
        @collection ||= ChallengesCollection.new(model.all, filter_params).results
      end

      private

      def filter_params
        params.permit(:user_id, :page, :per_page, :title,
                      published_at: %i[gte lte], created_at: %i[gte lte],
                      start_time: %i[gte lte], end_time: %i[gte lte])
      end

      def permitted_params
        params.permit(:title, :description, :start_time, :end_time, :published_at)
      end

      def new_resource
        @new_resource ||= User.find(params[:user_id]).challenges.build(permitted_params)
      end
    end
  end
end
