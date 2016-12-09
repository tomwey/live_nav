# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"

set :output, "/data/www/apps/live_nav_production/current/log/cron.log"

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# set :environment, :development

# set :environment, :development

every 1.minute do
  # command "echo 'this is test'"
  runner "DouyuCheck.update_state"
  # rake "some:great:rake:task"
end

# Learn more: http://github.com/javan/whenever
