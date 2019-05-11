class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable, :lockable

  enum role: [:user, :artist, :admin]
    after_initialize :set_default_role, :if => :new_record?

    def set_default_role
      self.role ||= :user
    end
    has_many :songs

    def set_password_reset
    # this will ensure users with duplicate codes
    self.reset_code = loop do
      code = SecureRandom.urlsafe_base64
      break code unless User.exists?(reset_code: code)
    end
    # set the expiration date with some handy date methods
    self.expires_at = 4.hours.from_now
    self.save
  end

end
