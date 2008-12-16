class CreateIntervals < ActiveRecord::Migration
  def self.up
    create_table :intervals do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.float :total_time
      t.string :comment
      t.boolean :ignore
      t.string :category
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :intervals
  end
end
