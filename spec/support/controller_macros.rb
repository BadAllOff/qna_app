module ControllerMacros
  def sign_in_user
    before do
      @user = create(:user)
      @user.role_sid = 'user'
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end

  def sign_in_admin
    before do
      @user = create(:user)
      @user.role_sid = 'admin'
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end

  def sign_in_another_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in another_user
    end
  end
end