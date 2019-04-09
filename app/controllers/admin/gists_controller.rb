class Admin::GistsController < Admin::BaseController

  def index
    @gists = Gist.all
  end

  def destroy
    Gist.find(params[:id]).destroy
    redirect_to admin_gists_path
  end
end
