class NotesController < ApplicationController
  wrap_parameters format: []

  def index
    render json: Note.all.order(:id)
  end

  def show
    @note = Note.find(params[:id])
    render json: @note
  end

  def create
    job = NoteAddJob.perform_later notes_to_add

    redirect_to job_status_path(id: job.provider_job_id)
  end

  def update
    job = NoteUpdateJob.perform_later notes_to_update

    redirect_to job_status_path(id: job.provider_job_id)
  end

  def destroy
    Note.where(id: notes_to_delete).destroy_all

    render status: :no_content
  end

  private
  def notes_params
    params.permit(notes: [:title, :description, :id]).require(:notes)
  end

  def notes_to_add
    notes_params.select { |x| x[:id].nil? }
  end

  # will update only existing notes
  def notes_to_update
    notes_params.select { |x| x[:id] }
  end

  def notes_to_delete
    notes_params.select { |x| x[:id] }.pluck(:id)
  end
end
