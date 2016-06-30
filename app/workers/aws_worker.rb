class AwsWorker
  include Sidekiq::Worker
  def perform(command)
    command
  end
end
