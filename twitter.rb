require 'Nokogiri'
require 'open-uri'
class TwitterScrapper
  def initialize(url)
  	html_file = open(url)
  	@doc = Nokogiri::HTML(File.open(html_file))
  	@arraytweet = []
	@array_date = []
	@array_like = []
  end

  def extract_username
  	profile_name = @doc.search(".ProfileHeaderCard-name > a")
  	"Username: #{profile_name.first.inner_text}"
  end

  def extract_tweets
  	profile_name = @doc.search(".ProfileNav-list")
  	profile_name.inner_text
  	profile_name.inner_text.split[4]
  end

  def extract_following
  	profile_name = @doc.search(".ProfileNav-list")
  	profile_name.inner_text
  	profile_name.inner_text.split[7]
  end

  def extract_followers
  	profile_name = @doc.search(".ProfileNav-list")
  	profile_name.inner_text
  	profile_name.inner_text.split[10]
  end

  def extract_likes
  	profile_name = @doc.search(".ProfileNav-list")
  	profile_name.inner_text
  	profile_name.inner_text.split[15]
  end

  def extract_lists
  	profile_name = @doc.search(".ProfileNav-list")
  	profile_name.inner_text
  	profile_name.inner_text.split[18]
  end

  def extract_stats
  	"Stats: Tweets: #{extract_tweets}, Siguiendo: #{extract_following}, Seguidores: #{extract_followers}, Me Gusta: #{extract_likes}, Listas: #{extract_lists}"
  end

  def extract_tweet
  	@arraytweet = []
  	(0..9).each do |i|
  	  profile_name = @doc.search(".js-tweet-text-container")[i]
  	  @tweet = profile_name.inner_text
  	  profile_name.each do |x|
  		@arraytweet << @tweet
  	  end
    end
  	@arraytweet
  end

  def extract_tweetlike
	@array_like = []
	(0..9).each do |i|
	  profile_name = @doc.search(".js-actionFavorite > span")
	  profile_name.inner_text
	  @like = profile_name.inner_text.split
	  @like.uniq[i]
	  @like.each do |x|
	  	@array_like << @like
	  end
	  @array_like.uniq[0]
	end
	  @array_like.uniq[0]
  end

  def extract_conc_tweets
  	@a = extract_tweetlike.uniq
  	extract_tweet.each_with_index do |item, index|
		puts  "The tweet with number #{index} and that says #{item}: has #{@a[index]} Likes"
  	end
  	
  end
end

twitter = TwitterScrapper.new('https://www.twitter.com/cnbc')
p twitter.extract_username
puts "----------------------------------------------------------------------------------------"
p twitter.extract_stats
puts "----------------------------------------------------------------------------------------"
puts "Tweets: "
twitter.extract_conc_tweets






