class CreatePodcastEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :podcast_episodes do |t|
      t.belongs_to :podcast, null: false, foreign_key: true
      t.datetime :aired_at, null: false
      t.string :title, null: false
      t.text :show_notes
      t.text :audio_file_url, null: false

      t.timestamps
    end
  end
end
