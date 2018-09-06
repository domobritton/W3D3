class ChangeVisitsIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :visits, name: :index_visits_on_shortened_url_id, unique: true 
    remove_index :visits, name: :index_visits_on_user_id, unique: true 
    add_index :visits, :shortened_url_id, unique: false 
    add_index :visits, :user_id, unique: false 
  end
end
