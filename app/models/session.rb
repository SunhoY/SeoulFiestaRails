class Session < ActiveRecord::Base
  belongs_to :user
  before_save :create_token

  def create_token
    self.token = generate_token(128)
  end

  def generate_token length
    allowed_characters = ('a'..'z').to_a + (0..9).to_a
    (1..length).collect { allowed_characters[SecureRandom.random_number(allowed_characters.size)] }.join
  end
end