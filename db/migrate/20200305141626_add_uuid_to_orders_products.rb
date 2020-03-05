class AddUuidToOrdersProducts < ActiveRecord::Migration[6.0]
  def up
    add_column :orders_products, :id, :uuid, default: "gen_random_uuid()", null: false
    execute "ALTER TABLE orders_products ADD PRIMARY KEY (id);"
    add_column :orders_products, :quantity, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
