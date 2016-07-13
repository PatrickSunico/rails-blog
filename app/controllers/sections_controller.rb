class SectionsController < ApplicationController
  layout "admin"
  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:name => "Write a Title"})
  end

  def create
    @section = Section.new(section_parameters)
    if @section.save
      flash[:notice] = "Successfully published a new section"
      redirect_to(:action => "index")
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    if @section.update_attributes(section_parameters)
      flash[:notice] = "Successfully updated a new section"
      redirect_to(:action => "show", :id => @section.id)
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id]).destroy
    flash[:notice] = "Successfully Deleted a section"
    redirect_to(:action => "index")
  end

  private
    def section_parameters
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end
end
