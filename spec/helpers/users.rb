def sign_up
  User.create(email:'pete@hrc.com', password: 'testtest')
end

def sign_in(email, password)
  visit '/'
  click_link 'Sign In'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end