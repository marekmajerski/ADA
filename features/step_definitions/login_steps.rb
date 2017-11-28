condition using: [LoginPage, MainPage] do
  Given(/^I login to UTOPSA as "([^"]*)"$/) do |user|
    unless is_user_logged?
      email = Ada::Settings.users[user]['email']
      password = Ada::Settings.users[user]['password']
      fill_user_credentials!(email, password)
      login!
    end
  end

  Given(/^I open UTOPSA page$/) do
    visit("#{Ada::Settings.target_url}/login")
  end

  Then(/^I logout from UTOPSA$/) do
    logout!
  end
end

assertion using: MainPage do
  Then(/^I logged to UTOPSA$/) do
    verify is_user_logged?
  end
end
