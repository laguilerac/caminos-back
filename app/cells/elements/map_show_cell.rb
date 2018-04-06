class Elements::MapShowCell < Cell::ViewModel

  private

  def base
    return [] if model[:geometry].blank?
    {
      coordinates: model[:geometry].coordinates.first.map(&:reverse)
    }.to_json
  end

  def features
    return [] if options[:features].blank?
    options[:features].map do |feature|
      case feature[:geometry].geometry_type
      when RGeo::Feature::Point
        {
          coordinates: [feature[:geometry].coordinates],
          icon: image_path(feature.category_icon),
          type: 'marker',
        }
      when RGeo::Feature::Polygon
        {
          coordinates: feature[:geometry].coordinates.first.map(&:reverse),
          className: feature.category,
          type: 'polygon',
        }
      end
    end.to_json
  end
end
