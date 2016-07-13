class SubjectsController < ApplicationController

  layout "admin"
  def index
    # Since this controller is managing the Subjects Model we can to Class method queries that we defined in our Subject model then store it in a instance variable which can be interpolated through the view
    @subjects = Subject.sorted
  end

  def show
    # find a subject by it's param id from the url string ex. subject/show/:id => where :id is equal to the url id hash string
    @subject = Subject.find(params[:id])
  end

  def new
    # first answer doesn't need an instance variable to specified in this particular new action
    # second answer put an instance object anyway for best practice
    @subject = Subject.new({:name => "Default"})
  end

  def create
    # Instantiate a new object using form parameters, while whitelisting the attributes inside of the params hash
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject Created Successfully"
      redirect_to(:action => "index")
    else
      # If save fails, redisplay the form so user can fix problems render the new form_template
      render('new')
    end
  end

  # edit action to show the form with the existing values
  def edit
    # find the subject to edit
    @subject = Subject.find(params[:id])
  end

  # edit + save action when user submits the form back again to the server
  def update
    # Find the existing Object using the form parameters
    @subject = Subject.find(params[:id])

    # update the values
    # the update_attributes automatically saves and inserts the new values back into the table without reinitializing a table row
    if @subject.update_attributes(subject_params)
      flash[:notice] = "Subject Updated Successfully"

        redirect_to(:action => "show" , :id => @subject.id)
      else
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
    params.require(:subject).permit(:name, :position, :visible)
  end
end
