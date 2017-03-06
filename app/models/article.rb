class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

	after_save :reload_cache
	after_destroy :reload_cache
	
  def reload_cache
		$redis.del "articles"
	end

	default_scope { order(created_at: :desc) }
end
