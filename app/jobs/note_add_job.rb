class NoteAddJob < ApplicationJob
  queue_as :default

  def perform(notes_list)
    result = Note.insert_all(notes_list)
    store result: JSON.dump(result.rows.flatten)
  end
end
