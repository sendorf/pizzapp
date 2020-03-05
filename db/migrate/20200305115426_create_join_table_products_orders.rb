class CreateJoinTableProductsOrders < ActiveRecord::Migration[6.0]
  def change
    create_join_table :products, :orders, column_options: {type: :uuid} do |t|
      t.index [:product_id, :order_id]
      t.index [:order_id, :product_id]
    end
  end
end
