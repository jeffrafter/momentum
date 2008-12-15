class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.string :application
      t.string :path
      t.string :window
      t.datetime :start_time
      t.datetime :end_time
      t.float :idle_time
      t.float :total_time
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
