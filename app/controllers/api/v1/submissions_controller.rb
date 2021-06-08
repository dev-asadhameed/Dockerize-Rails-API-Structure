# frozen_string_literal: true

module Api
  module V1
    class SubmissionsController < BaseController
      actions :create, :index, :show, :update

      def collection
        @collection ||= SubmissionsCollection.new(model.all, filter_params).results
      end

      private

      def filter_params
        params.permit(:submitted_by_id, :challenge_id, :page, :per_page, :status, :flagged,
                      :practice_submissions_count, created_at: %i[gte lte])
      end

      def permitted_params
        params.permit(:practice_submissions_count, :flagged, :status, :submitted_by_id, :challenge_id)
      end

      def new_resource
        @new_resource ||= User.find(params[:user_id]).submissions.build(permitted_params)
      end
    end
  end
end
