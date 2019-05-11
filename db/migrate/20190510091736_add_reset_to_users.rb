class AddResetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_code, :string
    add_column :users, :expires_at, :datetime
  end
end
