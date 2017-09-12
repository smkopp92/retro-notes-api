class NoteSerializer < ActiveModelSerializers::Model
  attributes :id, :text, :emotion
end
