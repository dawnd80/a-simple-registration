class CreateJobHistories < ActiveRecord::Migration
  def self.up
    create_table :job_histories do |t|
      t.string :title
      t.string :company
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :job_histories
  end
end
