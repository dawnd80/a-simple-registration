class User < ActiveRecord::Base
  has_many :job_histories,:dependent => :destroy  
  accepts_nested_attributes_for :job_histories
  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i

end
