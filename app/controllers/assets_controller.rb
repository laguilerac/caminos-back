class AssetsController < ApplicationController
  include CurrentAndEnsureDependencyLoader

  helper_method :current_neighborhood

  def create
    ensure_neighborhood; return if performed?

    service = CreateAsset.call(current_neighborhood, asset_params)

    if service.success?
      redirect_to neighborhood_assets_path
    else
      flash.now[:error] =  load_errors(service.errors)
      @categories = Asset.categories
      @asset = current_neighborhood.assets.new(asset_params)
      render action: :new
    end
  end

  def show
    load_asset
    @neighborhood = @asset.neighborhood
  end

  def new
    ensure_neighborhood; return if performed?

    @categories = Asset.categories
    @work = current_neighborhood.works.new
  end

  private

  def load_errors(errors)
    messages  = []
    errors.each do |error|
      messages << t('.errors', field: t(".#{error}"))
    end
    return messages
  end

  def load_asset
    @asset = Asset.friendly.find(params[:id])
  end

  def asset_params
    params.require(:asset).permit(
      :category_list,
      :description,
      :geo_geometry,
      :geometry,
      :lookup_address,
      :name,
    )
  end
end