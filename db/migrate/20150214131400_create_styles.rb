class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :style
      t.text :description

      t.timestamps null: false
    end
  end
end
