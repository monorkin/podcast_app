class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.text :url, null: false
      t.text :cover_art_url
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
