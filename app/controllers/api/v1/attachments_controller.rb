# frozen_string_literal: true

module Api
  module V1
    class AttachmentsController < BaseController
      actions :create, :index, :show, :update

      def collection
        @collection ||= AttachmentsCollection.new(model.all, filter_params).results
      end

      private

      def filter_params
        params.permit(:challenge_id, :submission_id, :name, :page, :per_page, created_at: %i[gte lte])
      end

      def permitted_params
        params.permit(:name, :url, :challenge_id, :submission_id)
      end
    end
  end
end
