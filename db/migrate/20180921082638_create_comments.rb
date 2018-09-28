class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :message
      t.integer :commented_id
      t.string :commented_type

      t.timestamps
    end

    add_index :comments, [:commented_id, :commented_type]
  end
end
