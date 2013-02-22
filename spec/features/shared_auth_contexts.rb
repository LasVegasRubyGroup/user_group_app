shared_context 'Signed In', :signed_in => true do
  let(:user) { create :user }
  before { login_as user }
end
