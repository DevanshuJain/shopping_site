module RequestSpecHelper

  include Warden::Test::Helpers
   

  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  def sign_in(resource)
    # scope = Devise::Mapping.find_scope!(resource)
    # login_as(resource, scope: scope)
    login_as(resource, scope: warden_scope(resource))
  end

  # def seller_sign_in(resource_or_scope, resource = nil)
  #   resource ||= resource_or_scope
  #   scope = Devise::Mapping.find_scope!(resource_or_scope)
  #   login_as(resource, scope: scope)
  #   byebug
  # end

  def sign_out(resource)
    logout(warden_scope(resource))
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end

end