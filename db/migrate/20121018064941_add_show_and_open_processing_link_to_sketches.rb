class AddShowAndOpenProcessingLinkToSketches < ActiveRecord::Migration
  def change
    add_column :sketches, :show, :boolean, :null => false, :default => true
    add_column :sketches, :openprocessing_link, :string
  end
end
