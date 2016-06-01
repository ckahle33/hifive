class UserFile < ActiveRecord::Base
  has_attached_file :media
                    
  validates_attachment :media, content_type:
    { :content_type =>
      [ "image/jpeg",
        "image/gif",
        "image/png",
        "video/avi",
        "video/mpeg",
        "video/m4v",
        "audio/aiff",
        "audio/x-aiff",
        "audio/midi",
        "audio/mpeg",
        "audio/x-mpeg",
        "audio/wav",
        "audio/mpeg3",
        "audio/mp3",
        "audio/x-mp3"
        ]
    }
end
