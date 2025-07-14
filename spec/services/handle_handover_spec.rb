require 'rails_helper'

RSpec.describe HandleHandover, type: :service do
  let(:client) { create(:client, status: :sem_notebook) }
  let(:notebook) { create(:notebook, state: :disponível) }

  describe 'create handover' do
    let(:params) { { client_id: client.id, notebook_id: notebook.id } }

    it 'creates a valid handover' do
      handover = HandleHandover.call('start', params, nil)

      expect(handover).to be_persisted
      expect(handover.start_date).to be_present
      expect(handover.start_state).to eq('start_emprestado')
      expect(handover.client).to eq(client)
      expect(handover.notebook).to eq(notebook)

      expect(client.reload.status).to eq('utilizando_notebook')
      expect(notebook.reload.state).to eq('emprestado')
    end

    it 'fails if notebook is not available' do
      notebook.update!(state: :emprestado)

      handover = HandleHandover.call('start', params, nil)

      expect(handover).not_to be_persisted
      expect(handover.errors[:notebook]).to include('já está emprestado ou indisponível')
    end

    it 'fails if client already has a notebook' do
      client.update!(status: :utilizando_notebook)

      handover = HandleHandover.call('start', params, nil)

      expect(handover).not_to be_persisted
      expect(handover.errors[:client]).to include('já possui um notebook emprestado')
    end
  end

  describe 'return handover' do
    let(:handover) do
      create(:handover, notebook: notebook, client: client, start_date: Time.current, start_state: :start_emprestado)
    end

    before do
      notebook.update!(state: :emprestado)
      client.update!(status: :utilizando_notebook)
    end

    it 'returns notebook successfully' do
      return_params = { cause: 'Uso concluído' }

      result = HandleHandover.call('return', return_params, handover)

      expect(result.final_state).to eq('final_disponível')
      expect(result.final_date).to be_present
      expect(result.cause).to eq('Uso concluído')

      expect(result.notebook.state).to eq('disponível')
      expect(result.client.status).to eq('sem_notebook')
    end

    it 'fails return if cause is missing' do
      result = HandleHandover.call('return', { cause: '' }, handover)

      expect(result.errors[:handover]).to include('justificativa não preenchida')
    end
  end
end
