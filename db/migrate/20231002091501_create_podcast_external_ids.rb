class CreatePodcastExternalIds < ActiveRecord::Migration[7.1]
  def change
    create_table :podcast_external_ids do |t|
      t.references :podcast, null: false, foreign_key: true
      t.bigint :provider, null: false
      t.string :identifier, null: false

      t.timestamps
    end

    add_index :podcast_external_ids, [:provider, :identifier], unique: true
  end
end
