require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
      it "renders the new template" do
        get :new, {}
        expect(response).to render_template("new")
        expect(response).to have_http_status(200)
      end
    end

    describe "GET #index" do
      it "renders the index template" do
        get :index, {}
        expect(response).to render_template("index")
        expect(response).to have_http_status(200)
      end
    end

    describe "GET #show" do
      context "with valid user id" do
        it 'renders the show template' do
          user = User.create(email: 'jason@fakesite.com', password: 'good_password')
          get :show, params: { id: user.id }
          expect(response).to render_template('show')
        end
      end

      context "with invalid user id" do
        it "renders the new template" do
          get :show, params: { id: -1 }
          expect(response).to render_template('new')
        end
      end
    end

    describe "POST #create" do
      context "with invalid params" do
        it "validates the presence of the user's email" do
          post :create, params: { user: { email: 'jason@fakesite.org' } }
          expect(response).to render_template('new')
          expect(flash[:errors]).to be_present
        end

        it "validates the presence of the user's password" do
          post :create, params: { user: { password: 'good_password' } }
          expect(response).to render_template('new')
          expect(flash[:errors]).to be_present
        end

        it "validates that the password is at least 6 characters long" do
          post :create, params: { user: { email: 'jason@fakesite.org', password: 'abc' } }
          expect(response).to render_template('new')
          expect(flash[:errors]).to be_present
        end
      end

      context "with valid params" do
        it "redirects user to bands index on success" do
          post :create, params: { user: { email: 'jason@fakesite.com', password: 'good_password' } }
          expect(response).to redirect_to(user_url(User.last))
        end
      end
    end
  end
