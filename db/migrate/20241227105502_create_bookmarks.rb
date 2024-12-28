class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer	:users_id
      t.integer	:posts_id

      t.timestamps
    end
  end
end
