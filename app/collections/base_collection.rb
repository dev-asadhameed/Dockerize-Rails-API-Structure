# frozen_string_literal: true
# BaseCollection is inherited by all other collections. It ensures all
# filters are applied to the collection.
class BaseCollection
  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= begin
      ensure_filters
      paginate
    end
  end

  private

  # ensure_filters will only lookup for those methods who starts with filter_by_
  def ensure_filters
    # private_methods returns the list of private methods accessible to obj. If the all parameter is set to
    # false, only those methods in the receiver will be listed.
    private_methods(false).grep(/\Afilter_by_/)&.each { |filter| send(filter) }
  end

  def filter
    @relation = yield(@relation)
  end

  def sort_records
    filter { @relation.reorder(params[:order_by].presence || 'created_at' => params[:order].presence || 'desc') }
  end

  def filter_by_time(field)
    return if (param_field = params[field.to_sym]).blank?

    if param_field[:gte].present? && param_field[:lte].present?
      filter_by_range(field)
    elsif param_field[:gte].present?
      filter_by_gte(field)
    else
      filter_by_lte(field)
    end
  end

  def filter_by_range(field)
    filter do
      @relation.where(field => DateTime.parse(params[field.to_sym][:gte])..DateTime.parse(params[field.to_sym][:lte]))
    end
  end

  def filter_by_gte(field)
    filter { @relation.where("#{field} >= ?", DateTime.parse(params[field.to_sym][:gte])) }
  end

  def filter_by_lte(field)
    filter { @relation.where("#{field} <= ?", DateTime.parse(params[field.to_sym][:lte])) }
  end

  def paginate
    return @relation unless params[:page]

    @relation.paginate(params[:page], per_page: params[:per_page])
  end

  def model
    @relation.model
  end
end
