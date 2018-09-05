class ChangeShortUrlNull < ActiveRecord::Migration[5.1]
  def change
    change_column :shortened_urls, :short_url, :string, null: true
  end
end
