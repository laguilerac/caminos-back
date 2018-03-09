class Elements::MapCell < Cell::ViewModel

  private

  def polygon
    polygon = model[:polygon]

    polygon.coordinates.first.map do |coords|
      coords.reverse
    end
  end

  def geo_polygon
    model[:geo_polygon]
  end

  def marker
    options[:work] ? options[:work].geometry.coordinates : 'null'
  end

  def geo_marker
    options[:work] ? options[:work].geo_geometry.coordinates : 'null'
  end

end