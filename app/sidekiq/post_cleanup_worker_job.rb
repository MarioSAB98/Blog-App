class PostCleanupWorkerJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    Post.where('created_at < ?', 24.hours.ago).destroy_all
  end
end