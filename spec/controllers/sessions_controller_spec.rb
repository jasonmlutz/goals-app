require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET new" do
    it 'renders the new template' do
      get :new, {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    user = User.create(email: 'jason@fakesite.com', password: 'good_password')
    context "with invalid credentials" do
      it 'checks for email in db' do
        post :create, params: { user: { email: 'empty@empty.com' , password: 'no_password' } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it 'checks for password match in db' do
        post :create, params: { user: { email: 'jason@fakesite.com', password: 'wrong_password' } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid credentials' do
      it 'redirects to the goals index' do
        post :create, params: { user: { email: 'jason@fakesite.com', password: 'good_password' } }
        expect(response).to redirect_to(goals_url)
      end
    end
  end

  describe 'DELETE destroy' do
    it "renders new session with no errors" do
      delete :destroy, {}
      expect(response).to render_template :new
      expect(flash[:errors]).to be_nil
    end
  end
end
