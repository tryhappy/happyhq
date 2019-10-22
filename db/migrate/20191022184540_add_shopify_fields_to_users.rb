class AddShopifyFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :shopify_api_key, :string
    add_column :users, :shopify_password, :string
    add_column :users, :shopify_url, :string
  end
end
