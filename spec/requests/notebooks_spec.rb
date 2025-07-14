# spec/requests/notebooks_spec.rb
require 'rails_helper'

RSpec.describe 'Notebooks', type: :request do
  let!(:notebook) { create(:notebook) }

  describe 'GET /notebooks' do
    it 'lista todos os notebooks' do
      get notebooks_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(notebook.equipment_id)
    end
  end

  describe 'GET /notebooks/:id' do
    it 'mostra um notebook específico' do
      get notebook_path(notebook)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(notebook.brand)
    end
  end

  describe 'GET /notebooks/new' do
    it 'exibe o formulário de novo notebook' do
      get new_notebook_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Novo Notebook')
    end
  end

  describe 'POST /notebooks' do
    context 'com parâmetros válidos' do
      let(:valid_params) { attributes_for(:notebook) }

      it 'cria um novo notebook e redireciona' do
        expect do
          post notebooks_path, params: { notebook: valid_params }
        end.to change(Notebook, :count).by(1)

        expect(response).to redirect_to(notebook_path(Notebook.last))
        follow_redirect!
        expect(response.body).to include('Notebook cadastrado com sucesso.')
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_params) { attributes_for(:notebook, brand: nil) }

      it 'reexibe o formulário de novo' do
        post notebooks_path, params: { notebook: invalid_params }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Novo Notebook')
      end
    end
  end

  describe 'PATCH /notebooks/:id' do
    context 'com parâmetros válidos' do
      let(:new_attributes) { { brand: 'HP' } }

      it 'atualiza o notebook e redireciona' do
        patch notebook_path(notebook), params: { notebook: new_attributes }
        notebook.reload
        expect(notebook.brand).to eq('HP')
        expect(response).to redirect_to(notebook_path(notebook))
        follow_redirect!
        expect(response.body).to include('Notebook atualizado com sucesso.')
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_attributes) { { brand: nil } }

      it 'reexibe o formulário de edição' do
        patch notebook_path(notebook), params: { notebook: invalid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Editar Notebook')
      end
    end
  end
end
