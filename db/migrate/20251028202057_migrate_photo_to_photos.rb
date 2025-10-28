class MigratePhotoToPhotos < ActiveRecord::Migration[7.0]
  def up
    say_with_time "Migrating existing :photo attachments to :photos" do
      ActiveStorage::Attachment.where(name: "photo", record_type: "Flat").find_each do |old_attachment|
        # Create a duplicate attachment with the new name
        ActiveStorage::Attachment.create!(
          name: "photos",
          record_type: old_attachment.record_type,
          record_id: old_attachment.record_id,
          blob_id: old_attachment.blob_id
        )
      end
    end
  end

  def down
    say_with_time "Rolling back :photos migration" do
      ActiveStorage::Attachment.where(name: "photos", record_type: "Flat").delete_all
    end
  end
end
