# frozen_string_literal: true

class ChallengesCollection < BaseCollection
  private

  def ensure_filters
    filter_by_end_time
    filter_by_created_at
    filter_by_start_time
    filter_by_title if params[:title]
    filter_by_user if params[:user_id]
    filter_by_published_at if params[:published_at]
  end

  def filter_by_published_at
    filter_by_time('published_at')
  end

  def filter_by_user
    filter { model.for_user(params[:user_id]) }
  end

  def filter_by_title
    filter { model.for_title(params[:title]) }
  end

  def filter_by_start_time
    filter_by_time('start_time')
  end

  def filter_by_end_time
    filter_by_time('end_time')
  end

  def filter_by_created_at
    filter_by_time('created_at')
  end
end
