class HelloApp

  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Hello Rack, #{env['REMOTE_USER']}!"]]
  end

end


class MyAuth < Rack::Auth::Basic

  def call(env)
    request = Rack::Request.new(env)
    if request.path == '/auth'
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