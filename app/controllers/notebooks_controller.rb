class NotebooksController < ApplicationController
  before_action :set_notebook, only: [:show, :edit, :update, :destroy]

  def index
    @notebooks = Notebook.all
  end

  def show; end

  def new
    @notebook = Notebook.new
  end

  def edit; end

  def create
    @notebook = Notebook.new(notebook_params)

    if @notebook.save
      redirect_to @notebook, notice: 'Notebook cadastrado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @notebook.update(notebook_params)
      redirect_to @notebook, notice: 'Notebook atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @notebook.destroy
    redirect_to notebooks_path, notice: 'Notebook excluído com sucesso.'
  end

  private

  def set_notebook
    @notebook = Notebook.find(params[:id])
  end

  def notebook_params
    params.require(:notebook).permit(:brand, :model, :asset_number, :serial_number, :equipment_id, :purchase_date,
                                     :manufacture_date, :description)
  end
end
