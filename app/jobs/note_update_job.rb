class NoteUpdateJob < ApplicationJob
  queue_as :default

  def perform(notes_list)
    result = notes_list.map do |item|
      note = Note.find_by_id item['id']
      next unless note

      Note.update(item.except('id'))
      note.id
    end

    store result: JSON.dump(result.compact)
  end
end
