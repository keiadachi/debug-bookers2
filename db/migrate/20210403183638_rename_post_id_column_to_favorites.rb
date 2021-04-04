class RenamePostIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change

    rename_column :favorites, :post_id, :book_id

  end
end
