class CreateToys < ActiveRecord::Migration[5.1]
  def change
    create_table :toys do |t|
      t.string :name
      t.integer :toyable_id
      t.string :toyable_type
      t.references :toyable, polymorphic: true, index: true
    end
  end
end
