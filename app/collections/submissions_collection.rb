# frozen_string_literal: true

class SubmissionsCollection < BaseCollection
  private

  def ensure_filters
    filter_by_created_at
    filter_by_status if params[:status]
    filter_by_flag if params[:flagged]
    filter_by_challenge if params[:challenge_id]
    filter_by_practice_submissions_count if params[:practice_submissions_count]
  end

  def filter_by_status
    filter { model.for_status(params[:status]) }
  end

  def filter_by_flagged
    filter { model.for_flagged(params[:flagged_by_id]) }
  end

  def filter_by_challenge
    filter { model.for_challenge(params[:challenge_id]) }
  end

  def filter_by_practice_submissions_count
    filter { model.for_practice_submissions_count(params[:practice_submissions_count]) }
  end

  def filter_by_created_at
    filter_by_time('created_at')
  end
end
