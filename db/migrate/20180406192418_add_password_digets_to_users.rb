class AddPasswordDigetsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end
# has to be called ':password_digest'