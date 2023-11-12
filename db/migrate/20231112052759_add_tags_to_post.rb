class AddTagsToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :tags, :text
  end
end
