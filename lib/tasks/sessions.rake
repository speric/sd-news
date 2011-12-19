namespace :sessions do
  desc "Clear all sessions > 1 day old"
  task(:clear => :environment) do
    ActiveRecord::Base.connection.execute "DELETE FROM sessions WHERE updated_at < \"#{(Time.now - 1.days).strftime('%Y-%m-%d 00:00:00')}\""
  end
end