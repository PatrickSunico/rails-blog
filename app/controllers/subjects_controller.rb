class SubjectsController < ApplicationController
  layout "admin"
  before_action :confirm_logged_in

  # Inherits :find_subject method from only on these instance methods/action routes
  before_action :find_subject, :only => [:show, :edit, :update,:delete, :destroy]
  def index
    @subjects = Subject.sorted
  end

  def show
  end

  def new
    # increment subject if user adds new subject
    @subject_count = Subject.count + 1
  end

  def create
    # check if subject values from fields are present
    if params[:subject].present?
      # create new subject with mass assignment with subject_params
      @subject = Subject.new(subject_params)
      # Save the object
      if @subject.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "Subject Created Successfully"
        redirect_to(:action => "index")
      else
        # If save fails,render the new form_template
        @subject_count = Subject.count + 1
        render('new')
      end

    else
        @subject_count = Subject.count + 1
        render('new')
    end
  end

  def edit
    # find the subject to edit using find_subject method

    @subject_count = Subject.count
  end

  # edit + save action when user submits the form back again to the server
  def update
    # Find the existing Subject using find_subjects method
    # Check if the subject has params
    if params[:subject].present?
    # update existing subject with new values
      if @subject.update_attributes(subject_params)
        flash[:notice] = "Subject Updated Successfully"
        redirect_to(:action => "show" , :id => @subject.id)
        else
          # If update fails, redisplay the form so user can fix problems
          @subject_count = Subject.count
          render('edit')
      end
    # Catch all errors re render edit if user reenters subjects/update
    else
        @subject_count = Subject.count
        render('edit')
    end
  end

  def delete
  end

  def destroy
    # store subject.name so we can print through flash notice
    subject_name = @subject.name
    @subject.destroy
    flash[:notice] = "Subject '#{subject_name}' Deleted successfully"
    redirect_to(:action => "index")
  end

  private
  # Finds the subject by it's parameter's id
  def find_subject
    @subject = Subject.find(params[:id])
  end
  # Permits which kinds of data that can be mass assigned, which then can be used as an argument whenever we are creating or updating a post
  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end
end
