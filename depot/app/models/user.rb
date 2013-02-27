class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation
  validates :name, presence: true, uniqueness: true
  has_secure_password
  after_destroy :ensure_an_admin_remains
  after_create :remove_temp_user_if_exists

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "last user can not be deleted"
    end
  end

  private
  def remove_temp_user_if_exists
    if User.count > 1 and User.find_by_name("rails_temp_user")
      temp_user = User.find_by_name "rails_temp_user"
      User.delete temp_user
    end
  end


end
