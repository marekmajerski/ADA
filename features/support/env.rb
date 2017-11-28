%w(
  ada
  cucumber/rspec/doubles
  pry
  stringio
  shellwords
  sidekiq/testing
).each(&method(:require))

# Run before the first step of each scenario
Before('~@omniauth') do
  OmniAuth.config.test_mode = true
end

# Run after the last step of each scenario
After do
  OmniAuth.config.test_mode = false
end

Before do
  # Make sure we don't try to send any emails by default
  System::Settings.emails['enabled'] = false

  # Clear file downloads
  Ada::Interactions::Page::FileDownload.clear_downloads

  # Perform background jobs immediately
  Sidekiq::Testing.inline!

  # Prepare cleaner (create pg dump).
  # We need here global vars because this solution is recommended by cucumber
  # rubocop:disable Style/GlobalVars
  Ada::Cleaner.instance.prepare! unless $adarun
  $adarun = true
  # rubocop:enable Style/GlobalVars
end

World(Test::Unit::Assertions)

After do |scenario|
  if scenario.failed?
    Ada::Savers::Screenshot.new(page).take!.tap do |screen_path|
      path = File.join(Rails.root, 'tmp', 'capybara', screen_path)
      Ada::Savers::S3::Sender.new.send!(path)
    end
  end
end

After do |_scenario|
  ActiveRecord::Base.connection.commit_db_transaction
  Ada::Cleaner.instance.restore!
end
