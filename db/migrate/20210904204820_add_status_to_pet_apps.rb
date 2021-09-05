class AddStatusToPetApps < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_apps, :status, :string
  end
end
