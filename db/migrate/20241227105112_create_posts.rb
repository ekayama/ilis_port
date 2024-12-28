class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer	:user_id
      t.integer	:posts_type_id
      t.string	:title
      t.text :body
      t.text :media_url

      t.timestamps
    end
  end
end
