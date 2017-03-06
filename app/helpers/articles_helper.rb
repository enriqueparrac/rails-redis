module ArticlesHelper

	def fetch_articles		
		articles =  $redis.get("articles")
		if articles.nil?		
			articles = Article.all.to_json
			$redis.set("articles", articles)
			# Expire the cache, every 3 hours
      $redis.expire("articles",3.hour.to_i)
		end
		@articles = JSON.load articles	
	end

end
