class AddColumnsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :kind, :string
    add_column :posts, :media, :string
    add_column :posts, :series, :string
    add_column :posts, :belong, :string
    add_column :posts, :group, :string
    add_column :posts, :geography, :string
    add_column :posts, :category, :string
  end
end
