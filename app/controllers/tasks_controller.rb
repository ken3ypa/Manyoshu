class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
