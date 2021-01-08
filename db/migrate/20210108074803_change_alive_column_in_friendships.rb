class ChangeAliveColumnInFriendships < ActiveRecord::Migration[6.0]
  def change
    change_column :friendships, :alive, :boolean, null: false
  end
end
