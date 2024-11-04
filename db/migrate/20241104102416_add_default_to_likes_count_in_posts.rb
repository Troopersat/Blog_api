# db/migrate/20241104102416_add_default_to_likes_count_in_posts.rb
class AddDefaultToLikesCountInPosts < ActiveRecord::Migration[7.1]
  def change
    # Step 1: Set all existing null values to 0 to avoid conflicts
    Post.where(likes_count: nil).update_all(likes_count: 0)

    # Step 2: Alter the column to set default to 0 and add null constraint
    change_column :posts, :likes_count, :integer, default: 0, null: false
  end
end
