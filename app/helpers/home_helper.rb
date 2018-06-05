module HomeHelper

  def average(neighborhood)
    if neighborhood
      return 0 if neighborhood.agreement.data.nil?
      indicators = JSON.parse(neighborhood.agreement.data)
      average = indicators.sum do |indicator|
        indicator[1]["score"].to_i
      end
      average / indicators.length
    end
  end

end