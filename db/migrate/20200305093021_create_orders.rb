class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.integer :total
      t.uuid :store_id

      t.timestamps
    end
  end
end
