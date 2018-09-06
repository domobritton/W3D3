# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string
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
  
  has_many :visits,
  primary_key: :id,
  foreign_key: :shortened_url_id,
  class_name: :Visit
  
  has_many :visitors,
  Proc.new { distinct },
  through: :visits,
  source: :visitors
  
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
  
  def num_clicks 
    self.visits.count
  end 
  
  def num_uniques 
    self.visits.select(:user_id).distinct.count
  end 
  
  def num_recent_uniques 
    time = 10.minutes.ago 
    self.visits.select(:user_id).distinct.where('created_at >= ?', time).count
  end 
  
  
end 











