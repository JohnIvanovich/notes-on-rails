class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    change_column_default :notes, :created_at, from: nil, to: -> { 'now()' }
    change_column_default :notes, :updated_at, from: nil, to: -> { 'now()' }
  end
end
