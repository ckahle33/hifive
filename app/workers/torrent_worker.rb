class TorrentWorker
  include Sidekiq::Worker
  def perform(command)
    system command
  end
end
