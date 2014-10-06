class AddAttachmentImageToTributes < ActiveRecord::Migration
  def self.up
    change_table :tributes do |t|

      t.attachment :image

    end
  end

  def self.down

    remove_attachment :tributes, :image

  end
end
