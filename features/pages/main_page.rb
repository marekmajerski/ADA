# Login Page, authentication form LinkedInn
class MainPage < Ada::Page
  element :create_a_new_account_button do
    "//button[@class='btn btn-primary add-btn']"
  end

  element :logout_button do
    "//*[@href='/logout']"
  end

  action :logout do
    logout_button.click!
  end

  verify :is_user_logged do
    create_a_new_account_button.exists?
  end
end
