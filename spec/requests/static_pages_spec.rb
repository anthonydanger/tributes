require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Tributes') }
    it { should have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1', text: 'Help') }
    it { should have_title( 'Tributes | Help') }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1', text: 'About') }
    it { should have_title( 'Tributes | About Us') }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1', text: 'Contact') }
    it { should have_title('Tributes | Contact') }
  end

  describe "Privacy page" do
    before { visit privacy_path }

    it { should have_selector('h1', text: 'Privacy') }
    it { should have_title('Tributes | Privacy') }
  end
end