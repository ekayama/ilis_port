class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer	:users_id
      t.string :posts_id
      t.text	:comment
      t.boolean	:is_public, null: false, default: false

      t.timestamps
    end
  end
end
