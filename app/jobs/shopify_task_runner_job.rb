class ShopifyTaskRunnerJob < ApplicationJob
  queue_as :default

  def perform(task)
    shop_url = "https://#{task.user.shopify_api_key}:#{task.user.shopify_password}@#{task.user.shopify_url}"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = '2019-10'

    product = ShopifyAPI::Product.find(task.object_id)

    product.title = task.instruction_value

    product.save
  end
end
