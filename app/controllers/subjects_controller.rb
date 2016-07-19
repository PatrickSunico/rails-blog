class SubjectsController < ApplicationController
  layout "admin"
  before_action :confirm_logged_in
  def index
    @subjects = Subject.sorted
  end

  def show
    # find a subject by its id
    @subject = Subject.find(params[:id])
  end

  def new
    # first answer doesn't need an instance variable to specified in this particular new action
    # second answer put an instance object anyway for best practice
    @subject = Subject.new({:name => "Default"})
    # increment subject if user adds new subject
    @subject_count = Subject.count + 1
  end

  def create
    # before we do the save check first if there are values inside of the fields and values inside of our params[:subject] hash else if not rerender the new page again
    if params[:subject].present?
      # Instantiate a new object using form parameters, while whitelisting the attributes inside of the params hash
      @subject = Subject.new(subject_params)
      # Save the object
      if @subject.save
        # If save succeeds, redirect to the index action
        flash[:notice] = "Subject Created Successfully"
        redirect_to(:action => "index")
      else
        # If save fails, redisplay the form so user can fix problems render the new form_template
        # if error display reference of number of subjects then re render edit
        @subject_count = Subject.count + 1
        # render('new')
        render('new')
      end

    else
        @subject_count = Subject.count + 1
        render('new')
    end
  end

  # edit action to show the form with the existing values
  def edit
    # find the subject to edit
    @subject = Subject.find(params[:id])
    # Returns the number of elements
    @subject_count = Subject.count

  end

  # edit + save action when user submits the form back again to the server
  def update
    # Find the existing Object using the form parameters
    @subject = Subject.find(params[:id])
    # Check if the subject has params
    if params[:subject].present?
    # update the values
    # the update_attributes automatically saves and inserts the new values back into the table without reinitializing a table row
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
    # Find the existing record to be deleted based on it's id
    @subject = Subject.find(params[:id])
    # if @subject.destroy
  end

  def destroy
    # define subject as a local instance variable so we can still manipulate it using string literals when it comes to showing an error on a subject_name on a page.
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' Destroy sucessfully"
    redirect_to(:action => "index")
  end

  # we make this method private so it can't be called as an action, then we append the name of this method to set a return value for the @subject instance inside the Subject.new as an instance
  # same as using "params[:subject]", except that it:
  # - raises an error if :subject is not present
  # - allows listed attributes to be mass-assigned
  private
  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end
end
