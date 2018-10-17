ThinkingSphinx::Index.define :question, with: :active_record do
  # fields
  indexes email, sortable: true
end