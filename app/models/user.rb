class User < ActiveRecord::Base

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy

  has_attached_file :image, 
                    :storage  => :s3, 
                    :s3_credentials => { :bucket => ENV['AWS_BUCKET'],
                                         :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                                         :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                                        },
                    :styles => { :medium => "370x370", :thumb => "100x100" },
                    :default_url => "/images/:style/missing.png"
                    
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  default_scope { order('id DESC') }

  def request_match(user2)
  	self.friendships.create(friend: user2)
  end

  def accept_match(user2)
    self.friendships.where(friend: user2).first.update_attribute(:state, "ACTIVE")
  end

  def decline_match(user2)
    
    friendship = friendships.where(friend_id: user2).first
    inverse_friendship = inverse_friendships.where(user_id: user2).first
      
      if inverse_friendship
          self.inverse_friendships.where(user_id: user2).first.destroy
      else
          self.friendships.where(friend_id: user2).first.destroy
      end

  end


  def self.sign_in_from_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)

    create(
      image: process_uri(auth['info']['image'] + "?width=9999"),
      email: auth['info']['email'],
      provider: auth['provider'],
      uid: auth['uid'],
      name: auth['info']['name'],
      gender: auth['extra']['raw_info']['gender'],
      date_of_birth: auth['extra']['raw_info']['birthday'].present? ? Date.strptime( auth['extra']['raw_info']['birthday'], '%m/%d/%Y') : nil,
      location: auth['info']['location'],
      bio: auth['extra']['raw_info']['bio']
    )
  end

  def self.gender(user)
    
    case user.interest
      when "Male"
        where('gender = ?', 'male')
      when "Female"
        where('gender = ?', 'female')
      else
        all
    end

  end


  private

  def self.process_uri(uri)
     image_url = URI.parse(uri)
     image_url.scheme = 'https'
     image_url.to_s
  end

end
