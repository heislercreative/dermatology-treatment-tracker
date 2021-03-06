class PatientsController < ApplicationController

  get '/patients/new' do
    if !logged_in?
      redirect to '/'
    else
      erb :'/patients/new'
    end
  end

  post '/patients' do
    @patient = current_user.patients.build(params[:patient])
    current_user.save
    redirect to "/patients/#{@patient.id}"
  end

  get '/patients/:id' do
    if !logged_in?
      redirect to '/'
    else
      if current_patient
        @conditions = current_patient.conditions
        erb :'/patients/show'
      else
        redirect to '/home'
      end
    end
  end

  get '/patients/:id/edit' do
    if !logged_in?
      redirect to '/'
    else
      if current_patient
        erb :'/patients/edit'
      else
        redirect to '/home'
      end
    end
  end

  patch '/patients/:id' do
    if current_patient
      current_patient.update(params[:patient])
      redirect to "/patients/#{current_patient.id}"
    else
      redirect to '/home'
    end
  end

  get '/patients/:id/delete' do
    if !logged_in?
      redirect to '/'
    else
      if current_patient
        erb :'/patients/delete'
      else
        redirect to '/home'
      end
    end
  end

  delete '/patients/:id/delete' do
    if current_patient
      current_patient.delete
      redirect to '/home'
    end
  end

end
