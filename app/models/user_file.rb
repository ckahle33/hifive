class UserFile < ActiveRecord::Base
  has_attached_file :media

  after_create :fetch_torrent
  after_create :fetch_magnet

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
        "audio/x-mp3",
        "application/octet-stream",
        "application/x-bittorrent",
        "application/torrent"
        ]
    }

    # listen to directory changes and stream to S3
    def listen_path
      # Dir should be a constant
      new_dir = ''
      listener = Listen.to(ENV['BASE_MEDIA_PATH']) do |modified, added, removed|
        new_dir = added
        Rails.logger.debug added
      end

      Rails.logger.debug  new_dir
    end

    def fetch_torrent
      if self.media_content_type == "application/octet-stream"
        # raise self.inspect
        torrent = self.media.url.split("?")
        Rails.logger.debug torrent[0]
        begin
          exec("transmission-remote -a #{torrent[0]}")
        rescue
          puts "couldn't connect to server"
        end
      end
    end

    def fetch_magnet
      # byebug

      s3 = AWS::S3.new
      bucket = s3.buckets["hifive-web"]
      obj = bucket.objects["user_files"]

      Rails.logger.debug self.inspect

      if self.url
        system "mkdir #{ENV['BASE_MEDIA_PATH']}/#{self.name}"

        TorrentWorker.perform_async("webtorrent download '#{self.url}' -o '#{ENV['BASE_MEDIA_PATH']}/#{self.name}'")
        AwsWorker.perform_async(obj.write(Pathname.new("#{ENV['BASE_MEDIA_PATH']}/#{self.name}")))
      end
    end


end
