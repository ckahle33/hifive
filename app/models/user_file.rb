class UserFile < ActiveRecord::Base
  has_attached_file :media, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :media, content_type: { :content_type => [ "image/jpeg",  "image/gif", "image/png", "video/avi", "video/mpeg" ]} 
end
