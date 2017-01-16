class CreateAssessments < ActiveRecord::Migration[5.0]
  def change
    create_table :assessments do |t|
      t.integer :pulse
      t.integer :resps
      t.integer :sats
      t.decimal :temp
      t.decimal :weight
      t.integer :hb
      t.decimal :gluc
      t.integer :systolic
      t.integer :diastolic
    
      t.timestamps
    end
  end
end
