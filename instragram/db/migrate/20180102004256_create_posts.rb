class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :contents	
      t.string :Avatar
      t.timestamps
    end
  end
end
