class CreateProductsStores < ActiveRecord::Migration[6.0]
  def change
    create_table :products_stores, id: :uuid do |t|
      t.uuid :store_id
      t.uuid :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
