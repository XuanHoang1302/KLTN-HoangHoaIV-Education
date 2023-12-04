class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # before_action :authenticate_user!

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :timeoutable

  has_many :notifications, as: :recipient, dependent: :destroy

  def initials
    [given_name.first, surname.first].join
  end
  def name
    [given_name, surname].compact.join(' ')
  end

  def name_and_email
    "#{name} (#{email})"
  end
end
