require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "profile page"
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_selector('h1', text: user.name) }
  	it { should have_title(user.name) }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', text: 'Signup') }
  	it { should have_title('Tributes | Signup') }

  end
end
