class TasksController < ApplicationController
  def index
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      label = params[:task][:label_id]
      if label.present?
        if title.present? && (status != "")
          @tasks = current_user.tasks.title_like(title).status_where(status).where(id: Label.find(label).tasks.pluck(:id)).page(params[:page]).per(15)
        elsif title.present? && (status == "")
          @tasks = current_user.tasks.title_like(title).where(id: Label.find(label).tasks.pluck(:id)).page(params[:page]).per(15)
        elsif title.blank? && (status != "")
          @tasks = current_user.tasks.status_where(status).where(id: Label.find(label).tasks.pluck(:id)).page(params[:page]).per(15)
        else
          @tasks = current_user.tasks.where(id: Label.find(label).tasks.pluck(:id)).page(params[:page]).per(15)
        end
      else
        if title.present? && (status != "")
          @tasks = current_user.tasks.title_like(title).status_where(status).page(params[:page]).per(15)
        elsif title.present? && (status == "")
          @tasks = current_user.tasks.title_like(title).page(params[:page]).per(15)
        elsif title.blank? && (status != "")
          @tasks = current_user.tasks.status_where(status).page(params[:page]).per(15)
        else
          redirect_to tasks_path
        end
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
    @task = current_user.tasks.find(params[:id])
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
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスクを編集しました。"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = 'タスクを削除しました'
    redirect_to tasks_path
  end
  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, label_ids: [])
  end
end
