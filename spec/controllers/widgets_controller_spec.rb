require 'rails_helper'

RSpec.describe WidgetsController, type: :controller do
  let(:valid_attributes) do
    { name: 'a name' }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Widget.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      widget = Widget.create! valid_attributes
      get :show, params: { id: widget.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      widget = Widget.create! valid_attributes
      get :edit, params: { id: widget.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Widget' do
        expect do
          post :create, params: { widget: valid_attributes }
        end.to change(Widget, :count).by(1)
      end

      it 'redirects to the created widget' do
        post :create, params: { widget: valid_attributes }
        expect(response).to redirect_to(Widget.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'a new name' }
      end

      it 'updates the requested widget' do
        widget = Widget.create! valid_attributes
        put :update, params: { id: widget.to_param, widget: new_attributes }
        widget.reload
        expect(widget.name).to eql new_attributes[:name]
      end

      it 'redirects to the widget' do
        widget = Widget.create! valid_attributes
        put :update, params: { id: widget.to_param, widget: valid_attributes }
        expect(response).to redirect_to(widget)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested widget' do
      widget = Widget.create! valid_attributes
      expect do
        delete :destroy, params: { id: widget.to_param }
      end.to change(Widget, :count).by(-1)
    end

    it 'redirects to the widgets list' do
      widget = Widget.create! valid_attributes
      delete :destroy, params: { id: widget.to_param }
      expect(response).to redirect_to(widgets_url)
    end
  end
end
