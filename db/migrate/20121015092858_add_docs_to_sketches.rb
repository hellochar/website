class AddDocsToSketches < ActiveRecord::Migration
  def change
    add_column :sketches, :text_left, :text
    add_column :sketches, :text_right, :text
    add_column :sketches, :html, :text
  end
end
