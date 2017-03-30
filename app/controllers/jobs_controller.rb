class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new()
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    # binding.pry
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      flash[:failure] = "Job not created. Please fill in all  required fields"
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
  end

  def update
    # @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @job.update(job_params)
    # redirect_to company_job_path(@company, @job) #any way to redirect without finding company?
    # redirect_to company_job_path(params[:company_id], @job) #is this better, since it skips Company.find?
    render :show       #Probably best method
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to company_jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
