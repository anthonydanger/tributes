require 'spec_helper'

describe User do
  
  before { @user = User.new(name: 'Example User', email: 'user@example.com', 
  											password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe "when name is left blank" do
  	before { @user.name = "" }
  	it { should_not be_valid }
  end

  describe "when name is longer than 50" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email is blank" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when email is wrong format" do
  	it "should be invalid" do
  		addresses = %w[foo@email,com user@foo+bar.com example@foo foo.bar.com foo@bar..com]
  		addresses.each do |address|
  			@user.email = address
  			expect(@user).not_to be_valid
  		end
  	end
  end

  describe "when email is correct format" do
  	it "should be valid" do
  		addresses = %w[UseR@ExamPle.CoM f.o.o@b.a.r.com juan@email.mx]
  		addresses.each do |address|
  			@user.email = address
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email already exists and case insensitivity" do
	  before do
	  	user_w_same_email = @user.dup
	  	user_w_same_email.email = @user.email.upcase
	  	user_w_same_email.save
	  end

	  it { should_not be_valid }
	end

	describe "when password is not present" do
		before do
		 @user.password = @user.password_confirmation = " "
		end

		it { should_not be_valid }
	end

	describe "when password doesn't match" do
		before do
			@user.password_confirmation = "something"
		end

		it { should_not be_valid }
	end

	describe "with a password that is too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should_not be_valid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		context "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end

		context "with invalid password" do
			let(:user_w_invalid_password) { found_user.authenticate("foobar") }

			it { should_not eq user_w_invalid_password }
			specify { expect(user_w_invalid_password).to be_false }
		end
	end

  describe "remember_token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end 
end
