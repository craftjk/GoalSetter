class User < ActiveRecord::Base
  attr_accessible :password, :token, :username, :password_digest
  attr_reader :password

  validates_uniqueness_of :username
  validates_presence_of :token, :username
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :token, :must_have_token

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_token
    self.token = SecureRandom::urlsafe_base64(16)
    self.save
    self.token
  end

  private

  def must_have_token
    self.reset_token if self.token.nil?
  end

end
