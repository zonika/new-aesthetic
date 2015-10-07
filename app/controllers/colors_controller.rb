class ColorsController < ApplicationController
  def search
    color = Colorcard.find_by(name:params[:color])
    colors = WorkColorcard.where(colorcard_id: color.id).order(:rank)
    @results = colors.collect do |work|
      Work.find(work.work_id)
    end
    render 'search_results'
  end
end
