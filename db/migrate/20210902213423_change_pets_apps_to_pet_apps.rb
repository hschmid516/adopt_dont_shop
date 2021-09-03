class ChangePetsAppsToPetApps < ActiveRecord::Migration[5.2]
  def change
    rename_table :pets_apps, :pet_apps
  end
end
