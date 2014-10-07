class CarConfig < ActiveRecord::Base
  # save price valid

  def valid_for_user?(user)
    true
  end
end
