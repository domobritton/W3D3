# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :user_id, presence: true, uniqueness: true 
  validates :short_url, uniqueness: true
  
  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User
  
  def self.random_code
    random = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64
    end 
    random 
  end 
  
  def self.generate(long_url, user)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(long_url: long_url, user_id: user.id, short_url: short_url)
  end 
  
end 
