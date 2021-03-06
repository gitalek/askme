require 'openssl'

# User model class
class User < ApplicationRecord
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: { maximum: 40 },
                       format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :email, format:
    { with: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  before_validation :normalize_username!

  attr_accessor :password
  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    return unless password.present?

    # создаём т.н. "соль" - рандомная строка, усложняющая задачу хакерам
    self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

    # создаём хэш пароля - длинная уникальная строка,
    # из которой невозможно восстановить исходный пароль
    self.password_hash = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(password,
                                 password_salt,
                                 ITERATIONS,
                                 DIGEST.length,
                                 DIGEST)
    )
  end

  def normalize_username!
    self.username = username.downcase unless username.nil?
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end
