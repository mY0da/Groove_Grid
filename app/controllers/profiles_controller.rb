class ProfilesController < ApplicationController
  include Wicked::Wizard

  steps :add_info, :add_avatar

  def show
    @user = current_user
    @profile = Profile.new(user: current_user)
    render_wizard
  end


  def update
    @profile = Profile.find_or_initialize_by(user: current_user)
    @profile.status = step.to_s
    @profile.status = 'active' if step == steps.last
    @profile.update(profile_params)
    render_wizard @profile
  end


  def create
    @profile = Profile.create
    redirect_to wizard_path(steps.first, profile_id: @profile.id)
  end

  def finish_wizard_path
    root_path
    ##new tagprofile path
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name,:last_name,:avatar)
  end
end
