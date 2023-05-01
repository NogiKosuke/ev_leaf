class TasksController < ApplicationController
  def index
    if params[:task].present?
      # title = params[:task][:title]
      # status = params[:task][:status]
      # label_id = params[:task][:label_id]
      
      @tasks = Task
        .title_like(params[:task][:title])
        .status_where(params[:task][:status])
        .tasks_label_where(params[:task][:label_id])
        .paginate(params)
      # if label_id.present?
      #   if title.present? && (status != "")
      #     @tasks = current_user.tasks.title_like_and_status_where(title, status).tasks_label_where(label_id).paginate(params)
      #   elsif title.present? && (status == "")
      #     @tasks = current_user.tasks.title_like(title).tasks_label_where(label_id).paginate(params)
      #   elsif title.blank? && (status != "")
      #     @tasks = current_user.tasks.status_where(status).tasks_label_where(label_id).paginate(params)
      #   else
      #     @tasks = current_user.tasks.tasks_label_where(label_id).paginate(params)
      #   end
      # else
      #   if title.present? && (status != "")
      #     @tasks = current_user.tasks..title_like(title).status_where(status).paginate(params)
      #   elsif title.present? && (status == "")
      #     @tasks = current_user.tasks.title_like(title).paginate(params)
      #   elsif title.blank? && (status != "")
      #     @tasks = current_user.tasks.status_where(status).paginate(params)
      #   else
      #     redirect_to tasks_path
      #   end
      # end
    else
        return @tasks = current_user.tasks.sort_limit.paginate(params) if params[:sort_expired].present?
        return @tasks = current_user.tasks.sort_priority.paginate(params) if params[:sort_priority].present?
        @tasks = current_user.tasks.latest.paginate(params)
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
