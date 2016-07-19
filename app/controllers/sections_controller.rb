class SectionsController < ApplicationController
  layout "admin"
  before_action :confirm_logged_in
  before_action :find_section, :only => [:show,:edit,:update,:delete,:destroy]
  def index
    @sections = Section.sorted
  end

  def show
    # show a section by it's id from our defined before_action "section_find"
  end

  def new
    @section = Section.new({:name => "Write a Title"})
    # Increment + 1 if user makes a new page
    @section_count = Section.count + 1
    @pages = Page.order('position ASC')
  end

  def create
    if params[:section].present?
      @section = Section.new(section_parameters)
      if @section.save
        flash[:notice] = "Successfully published a new section"
        redirect_to(:action => "index")
      else
        # If error, redisplay form then on submit increment Section.count
        @section_count = Section.count + 1
        @pages = Page.order('position ASC')
        render('new')
      end

      # catch all block if user re-enters the same route twices this solves the missing param values error.
    else
      @section_count = Section.count + 1
      @pages = Page.order('position ASC')
      render('new')
    end
  end

  def edit
    @pages = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    #first find the section to update by using our defined before_action "find_section"
    if params[:section].present?

      if @section.update_attributes(section_parameters)
        flash[:notice] = "Successfully updated a new section"
        redirect_to(:action => "show", :id => @section.id)
      else
        @pages = Page.order('position ASC')
        @section_count = Section.count
        render('edit')
      end
      # catch all block if user re-enters the same route twice, this solves the missing param values error.
    else
      @pages = Page.order('position ASC')
      @section_count = Section.count
      render('edit')
    end
  end

  def delete
  end

  def destroy

    # @section = Section.find(params[:id]).destroy
    section_name = @section.name
    @section.destroy
    flash[:notice] = "Successfully Deleted '#{section_name}'"
    redirect_to(:action => "index")
  end

  private
    def find_section
      @section = Section.find(params[:id])
    end
    def section_parameters
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end
end
