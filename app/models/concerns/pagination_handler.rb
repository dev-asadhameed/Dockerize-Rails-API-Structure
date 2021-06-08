# frozen_string_literal: true

require 'active_support/concern'

module PaginationHandler
  extend ActiveSupport::Concern

  included do
    def self.paginate(page, per_page: 20)
      pagy = Pagy.new(count: count(:all), page: page, items: per_page)
      { page_info: pagy, results: offset(pagy.offset).limit(pagy.items) }
    end
  end
end
