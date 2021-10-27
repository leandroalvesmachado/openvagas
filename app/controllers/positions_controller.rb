class PositionsController < ApplicationController

  # regra para todas as actions
  before_action :set_company, :set_i18n_careers, :set_i18n_contracts

  # regra executada apenas nos metodos informados
  before_action :set_position, only: [:edit, :show, :update]

  def index
    @positions = @company.positions
  end

  def new
    @position = @company.positions.new
    @careers = set_i18n_careers
    @contracts = set_i18n_contracts
  end

  def edit
  end

  def show
  end

  def create
    @position = @company.positions.new(params_position)

    if @position.save
      flash[:success] = 'Vaga cadastrada com sucesso.'
      redirect_to positions_path
    else
      render :new
    end
  end

  def update
    if @position.update(params_position)
      redirect_to positions_path
    else
      render :edit
    end
  end

  private

  def set_position
    @position = @company.positions.find(params[:id])
  end

  def params_position
    params.require(:position).permit(
      :name,
      :career,
      :contract,
      :remote,
      :publish,
      :city,
      :state,
      :summary,
      :description
    )
  end

  def set_company
    # esse if funciona assim: redireciona para a rota se o usuario logado nao possuir uma empresa
    redirect_to new_company_path if current_user.company.nil?
    @company = current_user.company
  end

  def set_i18n_careers
    # @careers = []
    # Position.careers.each_with_index do |career, index|
    #   @careers << [
    #     Position.careers.to_a[index].first,
    #     I18n.t('activerecord.attributes.position.careers').values.to_a[index]
    #   ]
    # end

    @careers = I18n.t('activerecord.attributes.position.careers')
  end

  def set_i18n_contracts
    # @contracts = []
    # Position.contracts.each_with_index do |career, index|
    #   @contracts << [
    #     Position.contracts.to_a[index].first,
    #     I18n.t('activerecord.attributes.position.contracts').values.to_a[index]
    #   ]
    # end

    @contracts = I18n.t('activerecord.attributes.position.contracts')
  end
end
