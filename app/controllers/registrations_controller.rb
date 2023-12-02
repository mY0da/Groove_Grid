class RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  protected

    def after_sign_in_path_for(resource)
      profiles_path
    end
end
