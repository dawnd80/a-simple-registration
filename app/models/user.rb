class User < ActiveRecord::Base
  acts_as_authentic do |a|
    a.validate_login_field(false)
  end

  has_many :job_histories,:dependent => :destroy  
  accepts_nested_attributes_for :job_histories
  
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email
  validates_format_of :email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i

  def full_name
    first_name + " " + last_name
  end
end
