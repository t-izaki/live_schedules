class InstrumentsController < ApplicationController
  before_action :set_instrument, only: %i[edit update destroy]

  def index
    @instruments = Instrument.all
  end

  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(create_update_params)
    if @instrument.save
      redirect_to instruments_path, notice: '楽器の作成に成功しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @instrument.update(create_update_params)
      redirect_to instruments_path, notice: '楽器の更新に成功しました'
    else
      render :edit
    end
  end

  def destroy
    if @instrument.destroy
      redirect_to instruments_path, notice: '楽器の削除に成功しました'
    else
      render :index
    end
  end

  private

  def set_instrument
    @instrument = Instrument.find(params[:id])
  end

  def create_update_params
    params.require(:instrument).permit(:name, :color)
  end
end
