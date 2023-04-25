class TasksController < ApplicationController
  def index
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && (status != "")
        @tasks = current_user.tasks.title_like(title).status_where(status).page(params[:page]).per(15)
      elsif title.present? && (status == "")
        @tasks = current_user.tasks.title_like(title).page(params[:page]).per(15)
      elsif title.blank? && (status != "")
        @tasks = current_user.tasks.status_where(status).page(params[:page]).per(15)
      else
        redirect_to tasks_path
      end
    else
      if params[:sort_expired].present?
        @tasks = current_user.tasks.order(expired_at: :asc).page(params[:page]).per(15)
      elsif params[:sort_priority].present?
        @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(15)
      else
        @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(15)
      end
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = "タスクを新規登録しました"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスクを編集しました。"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'タスクを削除しました'
    redirect_to tasks_path
  end
  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
