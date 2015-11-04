class CreateRegisteredApplications < ActiveRecord::Migration
  def change
    create_table :registered_applications do |t|
      t.text :name
      t.text :url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
