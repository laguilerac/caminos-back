class AgreementsController < ApplicationController
  include AgreementsParse
  before_action :check_for_mobile, only: %i[show]

  def show
    load_neighborhood
    load_agreement_data
  end

  private

  def load_agreement_data
    @agreement_data = parsed_agreement_data(@neighborhood.agreement)
  end

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end
end
