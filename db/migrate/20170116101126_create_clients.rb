class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :firstname
      t.string :surname
      t.string :urn
      t.string :dd
      t.string :mm
      t.string :yyyy

      t.timestamps
    end
  end
end
