class AddUuidToStores < ActiveRecord::Migration[6.0]
  def up
    add_column :stores, :uuid, :uuid, default: "gen_random_uuid()", null: false
    rename_column :stores, :id, :integer_id
    rename_column :stores, :uuid, :id
    execute "ALTER TABLE stores drop constraint stores_pkey;"
    execute "ALTER TABLE stores ADD PRIMARY KEY (id);"

    # Optinally you remove auto-incremented
    # default value for integer_id column
    execute "ALTER TABLE ONLY stores ALTER COLUMN integer_id DROP DEFAULT;"
    remove_column :stores, :integer_id, true
    execute "DROP SEQUENCE IF EXISTS stores_id_seq"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
