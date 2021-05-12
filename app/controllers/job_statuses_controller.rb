class JobStatusesController < ApplicationController
  def index
    status = Sidekiq::Status.status(job_id)

    # nil => 404
    # pending => sleep and reload
    # done => send notes

    if status == :complete
      ids_str = Sidekiq::Status.get(job_id, :result)
      render json: Note.where(id: JSON.parse(ids_str))
    elsif [:queued, :working].include?(status)
      sleep 5
      redirect_to job_status_path(id: job_id)
    else
      head :not_found
    end
  end

  private
  def job_id
    params.permit(:id).require(:id)
  end
end
