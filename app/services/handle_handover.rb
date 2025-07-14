class HandleHandover
  def initialize(action, handover_params, handover = nil)
    @action = action
    @handover_params = handover_params
    @handover = handover
  end

  def self.call(action, handover_params, handover = nil)
    new(action, handover_params, handover).call
  end

  def call
    run
  end

  private

  def run
    @action == 'start' ? create_handover : return_handover
  end

  # CREATE LOGIC
  def create_handover
    @handover = Handover.new(@handover_params)
    set_instances
    return @handover unless validate_handover

    prepare_handover
    return @handover unless persist_handover('Erro ao salvar')

    @handover
  end

  # RETURN LOGIC
  def return_handover
    set_instances
    return @handover unless validate_complete_handover

    prepare_return_handover
    return @handover unless persist_handover('Erro ao devolver')

    @handover
  end

  # SHARED METHODS
  def set_instances
    @notebook = @handover.notebook
    @client = @handover.client
  end

  def validate_handover # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity
    @handover.errors.add(:notebook, 'não pode estar em branco') if @notebook.blank?
    @handover.errors.add(:client, 'não pode estar em branco') if @client.blank?

    return false unless @notebook && @client

    @handover.errors.add(:notebook, 'já está emprestado ou indisponível') unless @notebook.disponível?
    @handover.errors.add(:notebook, 'está indisponível') if @notebook.indisponível?
    @handover.errors.add(:client, 'já possui um notebook emprestado') unless @client.sem_notebook?

    @handover.errors.empty?
  end

  def prepare_handover
    @client.status = :utilizando_notebook
    @notebook.state = :emprestado
    @handover.start_state = :start_emprestado
    @handover.start_date = Time.current
  end

  def validate_complete_handover
    @handover.errors.add(:handover, 'justificativa não preenchida') if @handover_params[:cause].blank?
    @handover.errors.empty?
  end

  def prepare_return_handover
    notebook_state = @action == 'write_off' ? :indisponível : :disponível
    handover_state = @action == 'write_off' ? :final_indisponível : :final_disponível

    @handover.final_date = Time.current
    @handover.final_state = handover_state
    @handover.cause = @handover_params[:cause]
    @handover.notebook.state = notebook_state
    @handover.client.status = :sem_notebook
  end

  def persist_handover(error_msg)
    ActiveRecord::Base.transaction do
      @client.save!
      @notebook.save!
      @handover.save!
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    @handover.errors.add(:base, "#{error_msg}: #{e.message}")
    false
  end
end
