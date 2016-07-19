class PagesController < ApplicationController
  layout "admin"
  before_action :confirm_logged_in
  before_action :find_page, :only => [:show, :edit, :update, :delete, :destroy]
  def index
    @pages = Page.sorted
  end

  def show
    # @page = Page.find(params[:id])
  end

  def new
    # Increment + 1 if user makes a new page
    @page_count = Page.count + 1
    # Access an instance of Subjects, To be passed through our edit template then can be accessed by our partial
    @subjects = Subject.order('position ASC')
  end

  def create
    if params[:page].present? # are values present? if yes continue
      @page = Page.new(page_params)
      if @page.save
        flash[:notice] = "Page Created Successfully"
        redirect_to(:action => "index")
      else
        # If save fails, redisplay the form so user can fix problems render the new form_template
        # if error display reference of number of pages then re render new
        @page_count = Page.count + 1
        @subjects = Subject.order('position ASC')
        render('new')
      end

      # catch all block errors then rerender page
    else
      @page_count = Page.count + 1
      @subjects = Subject.order('position ASC')
      render('new')
    end
  end

  def edit
    # Access an instance of Subjects, To be passed through our edit template then can be accessed by our partial
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    # check if page params has a value if so update the values
    if params[:page].present?

      if @page.update_attributes(page_params)
        puts params
        flash[:notice] = "Page Updated Successfully"
        redirect_to(:action => "show", :id => @page.id)
      else
        @subjects = Subject.order('position ASC')
        @page_count = Page.count

        render('edit')
      end

      # catch all route if user re-enters the same route in the browser
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
      render('edit')
    end
  end

  def delete
  end

  def destroy
    page_name = @page.name
    @page.destroy
    flash[:notice] = "Successfully Deleted '#{page_name}'"
    redirect_to(:action => "index")
  end

  private
    def find_page
      @page = Page.find(params[:id])
    end
    def page_params
      params.require(:page).permit(:subject_id ,:name, :permalink, :position, :visible)
    end
end
