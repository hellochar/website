class CreateSketches < ActiveRecord::Migration
  def change
    create_table :sketches do |t|
      t.string :name, :null => false
      t.datetime :entry_date, :null => false
      t.string :classpath, :null => false
      t.integer :width, :null => false, :default => 800
      t.integer :height, :null => false, :default => 600

      t.timestamps
    end
  end
end
