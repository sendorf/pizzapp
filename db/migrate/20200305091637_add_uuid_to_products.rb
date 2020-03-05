class AddUuidToProducts < ActiveRecord::Migration[6.0]
  def up
    add_column :products, :uuid, :uuid, default: "gen_random_uuid()", null: false
    rename_column :products, :id, :integer_id
    rename_column :products, :uuid, :id
    execute "ALTER TABLE products drop constraint products_pkey;"
    execute "ALTER TABLE products ADD PRIMARY KEY (id);"

    # Optinally you remove auto-incremented
    # default value for integer_id column
    execute "ALTER TABLE ONLY products ALTER COLUMN integer_id DROP DEFAULT;"
    remove_column :products, :integer_id, true
    execute "DROP SEQUENCE IF EXISTS products_id_seq"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
