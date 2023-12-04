# frozen_string_literal: true

User.where(email: 'buyer@example.com').first_or_create!(
  {
    title: 'mr',
    given_name: 'Buyer',
    surname: 'Tester',
    phone_number: '+36 1 123 4567',
    password: 'Password=1',
    password_confirmation: 'Password=1',
    confirmed_at: Time.current,
    role: 'buyer'
  }
)

User.where(email: 'admin@example.com').first_or_create!(
  {
    title: 'mr',
    given_name: 'Admin',
    surname: 'Tester',
    phone_number: '+36 1 123 4567',
    password: 'Password=1',
    password_confirmation: 'Password=1',
    confirmed_at: Time.current,
    role: 'admin'
  }
)
