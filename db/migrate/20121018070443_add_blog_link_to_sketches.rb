class AddBlogLinkToSketches < ActiveRecord::Migration
  def change
    add_column :sketches, :blog_link, :string
  end
end
