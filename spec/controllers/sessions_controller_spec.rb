require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET new" do
    it 'renders the new template'
  end

  describe 'POST create' do
    context "with invalid credentials" do
      it 'checks for email in db'

      it 'checks for password match in db'
    end

    context 'with valid credentials' do
      it 'renders the user template'
    end
  end
end
