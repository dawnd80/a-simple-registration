class Activation < ActiveRecord::Base
  before_validation :ensure_unique_key

  validates_presence_of :email, :unique_key
  validates_uniqueness_of :email
  validates_format_of :email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i

  def ensure_unique_key
    self.unique_key = ActiveSupport::SecureRandom.hex(20) until unique_key?
  end
  
  def unique_key?
    !unique_key.nil? and self.class.count(:all, :conditions => ["unique_key = ?", unique_key]) == 0
  end
end
