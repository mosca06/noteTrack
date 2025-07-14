class NotebooksController < ApplicationController
  before_action :set_notebook, only: [:show, :edit, :update, :destroy]

  def index # rubocop:disable Metrics/MethodLength
    @q = params[:q]
    @notebooks = Notebook.all

    if @q.present?
      query = "%#{@q}%"
      @notebooks = @notebooks
                   .left_joins(:handovers)
                   .where(
                     'notebooks.asset_number ILIKE :q OR notebooks.serial_number ILIKE :q OR notebooks.model ILIKE :q OR CAST(notebooks.purchase_date AS TEXT) ILIKE :q OR CAST(notebooks.state AS TEXT) ILIKE :q', # rubocop:disable Layout/LineLength
                     q: query
                   ).distinct
    end
  end

  def show
    @handovers = @notebook.handovers.order(start_date: :desc)
  end

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
    @notebook = Notebook.find(params[:id])

    if @notebook.pode_ser_excluido?
      @notebook.destroy
      redirect_to notebooks_path, notice: 'Notebook excluído com sucesso.'
    else
      redirect_to notebooks_path,
                  alert: 'Não é possível excluir este notebook: ele já foi emprestado ou não está disponível.'
    end
  end

  private

  def set_notebook
    @notebook = Notebook.find(params[:id])
  end

  def notebook_params
    params.require(:notebook).permit(:brand, :model, :asset_number, :serial_number, :equipment_id, :purchase_date,
                                     :manufacture_date, :description, :pdf)
  end
end
