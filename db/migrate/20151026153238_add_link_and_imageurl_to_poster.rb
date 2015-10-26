class AddLinkAndImageurlToPoster < ActiveRecord::Migration
  def change
    add_column :posters, :link, :string
    add_column :posters, :imageurl, :string
  end
end
