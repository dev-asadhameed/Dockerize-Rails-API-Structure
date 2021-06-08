# frozen_string_literal: true

# Fixes n+1 query problems.
module InferableEagerLoads
  extend ActiveSupport::Concern

  private

  def infer_eager_loads(scope)
    eager_load_scope(scope, self.class::DEFAULT_EAGER_LOADS)
  end

  def eager_load_scope(scope, includes)
    scope = scope.includes(*includes) if includes.present?
    scope.all
  end
end
