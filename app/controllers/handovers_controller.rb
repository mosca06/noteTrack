class HandoversController < ApplicationController
  before_action :set_handover, only: %i[complete_handover_form complete_handover]
  before_action :set_available_resources, only: %i[new create]

  def index
    @handovers = Handover.includes(:client, :notebook).order(created_at: :desc)
  end

  def show
    @handover = Handover.find(params[:id])
  end

  def new
    @handover = Handover.new
  end

  def create
    @handover = HandleHandover.call('start', handover_params)

    if @handover.persisted?
      redirect_to @handover, notice: 'Empréstimo criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def complete_handover_form; end

  def complete_handover
    action = complete_handover_params[:action]
    @handover = HandleHandover.call(action, complete_handover_params, @handover)

    if @handover.errors.empty?
      redirect_to @handover, notice: 'Operação realizada com sucesso.'
    else
      render :complete_handover_form, status: :unprocessable_entity
    end
  end

  private

  def set_handover
    @handover = Handover.find(params[:id])
  end

  def set_available_resources
    @available_clients = Client.where(status: :sem_notebook)
    @available_notebooks = Notebook.where(state: :disponível)
  end

  def handover_params
    params.require(:handover).permit(:client_id, :notebook_id)
  end

  def complete_handover_params
    params.require(:handover).permit(:cause, :action)
  end
end
