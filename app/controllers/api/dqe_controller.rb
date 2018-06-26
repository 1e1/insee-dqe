class Api::DqeController < ActionController::Base
  before_action :params_query, only: [:hack]

  def hack
    url = 'https://prod2.dqe-software.com/RNVP/'

    response = RestClient.get(url, params: params_query.to_h)

    # add _ to attributes which begin by a number
    output = response.gsub(/\"(\d[^\"]*)\":/, "\"_\\1\":")

    render json: output
  end
  
  private

  def params_query
    param_names = [:Adresse, :Instance, :Taille, :Pays, :Licence]
    params.permit(param_names).permit(param_names)
  end

end
