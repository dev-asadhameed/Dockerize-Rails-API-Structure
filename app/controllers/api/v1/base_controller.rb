# frozen_string_literal: true

module Api
  module V1
    class BaseController < ::ApiController
      include BaseHandler
      include ExceptionHandler
      include InferableEagerLoads

      DEFAULT_EAGER_LOADS = [].freeze

      before_action :authorize_resource, only: %i[show update destroy]
      before_action :authorize_new_resource, only: :create

      protected

      def index
        render json: authorize_resources
      end

      def create
        if new_resource.save
          render json: new_resource, status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update(permitted_params)
          render json: resource
        else
          render json: { message: 'Record can not be updated!', errors: resource.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def destroy
        if resource.destroy
          render json: resource
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource
      end

      def collection
        @collection ||= infer_eager_loads(resources)
      end

      def resources
        @resources ||= model.all
      end

      def resource
        @resource ||= model.find(params[:id])
      end

      def new_resource
        @new_resource ||= model.new(permitted_params)
      end

      def permitted_params
        {}
      end

      def authorize_resource
        authorize resource, policy_class: policy_class
      end

      def authorize_new_resource
        authorize new_resource, policy_class: policy_class
      end

      def authorize_resources
        page_info, scope = collection.is_a?(Hash) ? [collection[:page_info], collection[:results]] : [nil, collection]

        scope = scope.map do |resource|
          resource if authorize resource, policy_class: policy_class
        rescue Pundit::NotAuthorizedError
          nil
        end.compact

        if page_info
          serialized_data = ActiveModelSerializers::SerializableResource.new(scope, each_serializer: serializer,
                                                                                    options: options)
          { results: serialized_data, page_info: page_info }
        else
          { results: scope }
        end
      end

      def options
        {}
      end

      def serializer
        "#{model}Serializer".constantize
      end

      def policy_class
        "#{controller_name.singularize.classify}Policy".constantize
      end
    end
  end
end
