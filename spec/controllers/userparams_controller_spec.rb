require 'rails_helper'

RSpec.describe UserparamsController, type: :controller do
  let!(:user) { build(:user, email: "test@gmail.com") }

  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create Profile" do
      get :new
      expect(subject.current_user.email).to eq("tester@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it "should create profile and redirect to index page" do
      post :create, params: {userparam: {firstname:"Tester"}}
      post :create, params: {userparam: {lastname:"Test"}}
      post :create, params: {userparam: {age:"20"}}
      expect(subject.current_user.userparam.firstname).to eq("Tester")
      expect(subject.current_user.userparam.lastname).to eq("Test")
      expect(subject.current_user.userparam.age).to eq("20")
      expect(response).to redirect_to userparam_path(@userparam.id)
    end
  end

  describe 'GET #edit' do
    it "should find current_user and open form for edit Profile" do
      get :edit, xhr: true, format: :js, params: {id: subject.current_user.id}
      expect(subject.current_user.email).to eq("tester@test.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH #update' do
    before do
      @userparam = create(:profile, user_id: subject.current_user.id)
    end
    it "should update userparam and redirect to profile" do
      patch :update, params: { id: subject.current_user.id, profile: {nickname: "Tester2"}}
      expect(subject.current_user.profile.nickname).to eq("Tester2")
      expect(response).to redirect_to profile_index_path
    end
  end

  describe "#profile_info" do
    it "should show profile_info" do
      get :profile_info, xhr: true, format: :js
      expect(subject.current_user.email).to eq("tester@test.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
      # expect(subject.current_user.email).to eq("tester@test.com")
      it 'gowno' do
      expect(response).to have_http_status(200)
    end
  end
end
