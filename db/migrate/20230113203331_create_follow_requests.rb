class CreateFollowRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_requests do |t|
      t.references :recipient, null: false, foreign_key: { to_table: :users }, index: true
      t.references :sender, null: false, foreign_key: { to_table: :users }, index: true
      t.string :status, default: "pending", null: false

      t.timestamps
    end
  end
end
