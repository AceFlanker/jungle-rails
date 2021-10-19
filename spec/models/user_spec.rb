require 'rails_helper'

RSpec.describe Product, type: :model do

  before do
    @user = User.create(:first_name => 'Santa', :last_name => 'Claus', :email => "test@test.com", :password => "trustnoone", :password_confirmation => "trustnoone")
  end

  describe 'Validations' do

    it 'should not save when passwords don\'t match' do
      @user0 = User.create(:first_name => 'Santa', :last_name => 'Claus', :email => "TEST@TEST.com", :password => "trustnoone", :password_confirmation => "trustnobody")
      expect(@user0.id).to be_nil
    end

    it 'should not save when the email already exists in database' do
      @user1 = User.create(:first_name => 'Santa', :last_name => 'Claus', :email => "test@test.COM", :password => "trustnoone", :password_confirmation => "trustnoone")
      @user2 = User.create(:first_name => 'Santa', :last_name => 'Claus', :email => "TEST@TEST.com", :password => "trustnoone", :password_confirmation => "trustnoone")
      # puts "#{@user2.errors.full_messages}"
      expect(@user2.id).to be_nil
    end

    it 'should not save without a first name' do
      @user.update(first_name: nil)
      expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it 'should not save without a last name' do
      @user.update(last_name: nil)
      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    it 'should not save without a first name' do
      @user.update(email: nil)
      expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it 'should not save when the password is 8 characters or less' do
      @user3 = User.create(:first_name => 'Santa', :last_name => 'Claus', :email => "TEST@TEST.com", :password => "trustno", :password_confirmation => "trustno")
      expect(@user3.id).to be_nil
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should login with spaces before and/or after in the email string' do
      @user4 = User.authenticate_with_credentials("  test@test.com  ", "trustnoone")
      expect(@user4).to be_truthy
    end

    it 'should login with different cases in the email string' do
      @user4 = User.authenticate_with_credentials("tEst@TEsT.CoM", "trustnoone")
      expect(@user4).to be_truthy
    end

  end

end