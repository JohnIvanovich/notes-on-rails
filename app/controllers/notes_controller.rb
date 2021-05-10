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
    @notes = Note.insert_all(
      notes_to_add,
      returning: '*'
    )

    render json: @notes, status: :created
  end

  def update
    @notes = Note.upsert_all(
      notes_to_update,
      returning: '*'
    )

    render json: @notes
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
    notes = notes_params.select { |x| x[:id] }
    existing_notes_ids = Note.where(id: notes.pluck(:id)).ids
    notes.select { |x| existing_notes_ids.include?(x[:id]) }
  end

  def notes_to_delete
    notes_params.select { |x| x[:id] }.pluck(:id)
  end
end
