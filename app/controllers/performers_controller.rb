class PerformersController < ApplicationController
  before_action :set_performer, only: %i[show edit update destroy]

  def index
    @performers = Performer.all.includes(:instrument)
  end

  def show; end

  def new
    @performer = Performer.new
  end

  def create
    @performer = Performer.new(create_update_params)
    if @performer.save
      redirect_to performer_path(@performer), notice: '演奏者の作成に成功しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @performer.update(create_update_params)
      redirect_to performer_path(@performer), notice: '演奏者の更新に成功しました'
    else
      render :edit
    end
  end

  def destroy
    if @performer.destroy
      redirect_to performers_path, notice: '演奏者の削除に成功しました'
    else
      render :index
    end
  end

  private

  def set_performer
    @performer = Performer.find(params[:id])
  end

  def create_update_params
    params.require(:performer).permit(:name, :introduction, :instrument_id, :regular, :image_url, :icon_url)
  end
end
