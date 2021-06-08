# frozen_string_literal: true

class AttachmentsCollection < BaseCollection
  private

  def ensure_filters
    filter_by_created_at
    filter_by_name if params[:name]
    filter_by_challenge if params[:challenge_id]
    filter_by_submission if params[:submission_id]
  end

  def filter_by_submission
    filter { model.for_submission(params[:submission_id]) }
  end

  def filter_by_challenge
    filter { model.for_challenge(params[:challenge_id]) }
  end

  def filter_by_name
    filter { model.for_name(params[:name]) }
  end

  def filter_by_created_at
    filter_by_time('created_at')
  end
end
