# Login Page, authentication form LinkedInn
class LoginPage < Ada::Page
  element :login_button do
    "//button[@id='login']"
  end

  element :email_field do
    "//input[@id='inputEmail']"
  end

  element :password_field do
    "//input[@id='inputPassword']"
  end

  action :fill_user_credentials do |email, password|
    email_field.fill!(email)
    password_field.fill!(password)
  end

  action :login do
    login_button.click!
  end
end
