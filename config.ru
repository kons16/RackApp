require './scraping_news'

class HelloApp

  def call(env)
    sn = ScrapingNews.new
    titles = sn.scraping.to_json
    [200, {"Content-Type" => "application/json"}, [titles]]
  end

end


class MyAuth < Rack::Auth::Basic

  def call(env)
    request = Rack::Request.new(env)
    if request.path == "/auth"
      # Basic認証を回避
      @app.call(env)
    else
      super
    end
  end

end


use MyAuth do |username, password|
  [username, password] == %w(user password)
end

run HelloApp.new