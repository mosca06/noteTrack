require 'rails_helper'

RSpec.describe '/handovers', type: :request do
  let(:client) { create(:client, status: :sem_notebook) }
  let(:notebook) { create(:notebook, state: :disponível) }

  let(:valid_attributes) do
    {
      client_id: client.id,
      notebook_id: notebook.id
    }
  end

  let(:invalid_attributes) do
    {
      client_id: nil,
      notebook_id: nil
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:handover, client: client, notebook: notebook, start_state: :start_disponível, start_date: Time.current)
      get handovers_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      handover = create(:handover, client: client, notebook: notebook, start_state: :start_disponível,
                                   start_date: Time.current)
      get handover_url(handover)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_handover_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Handover' do
        expect do
          post handovers_url, params: { handover: valid_attributes }
        end.to change(Handover, :count).by(1)
      end

      it 'redirects to the created handover' do
        post handovers_url, params: { handover: valid_attributes }
        expect(response).to redirect_to(handover_url(Handover.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Handover' do
        expect do
          post handovers_url, params: { handover: invalid_attributes }
        end.not_to change(Handover, :count)
      end

      it 'renders a response with 422 status' do
        post handovers_url, params: { handover: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /complete_handover_form' do
    it 'renders a successful response' do
      handover = create(:handover, client: client, notebook: notebook, start_state: :start_disponível,
                                   start_date: Time.current)
      get complete_handover_form_handover_url(handover)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /complete_handover' do
    let(:handover) do
      create(
        :handover,
        client: client,
        notebook: notebook,
        start_state: :start_disponível,
        start_date: Time.current
      )
    end

    context 'with invalid parameters (missing cause)' do
      let(:handover) do
        create(:handover, client: client, notebook: notebook, start_state: :start_disponível, start_date: Time.current)
      end

      let(:invalid_return_params) do
        {
          handover: {
            action: 'return',
            cause: ''
          }
        }
      end

      it 'renders the form with errors' do
        patch complete_handover_handover_path(handover), params: invalid_return_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('justificativa não preenchida')
      end
    end
  end
end
