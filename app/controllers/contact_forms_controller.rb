class ContactFormsController < ApplicationController
  helper_method :current_or_guest_user

  def new
    @contact_form = ContactForm.new

  end

  def create
    @contact_form = ContactForm.new(params[:contact_form])
    @contact_form.subject = [@contact_form.subject_1, @contact_form.subject_2, @contact_form.subject_3,@contact_form.subject_4].reject(&:empty?).join(',')
    @contact_form.request = request
    if @contact_form.deliver
    flash[:success] = "Successfully Sent Custom Order, We Will Contact You Shortly"
    redirect_to new_contact_form_path
  else
      render :new
    end
  rescue ScriptError
    flash[:error] = 'Sorry, something was wrong'
    end
  end
