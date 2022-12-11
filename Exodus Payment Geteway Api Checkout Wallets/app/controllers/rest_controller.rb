class RestController < ApplicationController
  # Todo figure out how to put this back in
  # protect_from_forgery with: :exception.
  before_action :initialize_model, only: :new

  def new
    render json: model
  end

  def index
    render json: models
  end

  def show
    render json: model
  end

  def create
    @model = model_klass.new
    if @model.update(safe_filtered_params)
      render json: @model
    else
      render json: @model.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @model = model_klass.find(params[:id]).destroy!
    render json: @model
  end

  def update
    @model = model_klass.find(params[:id])
    if @model.update(safe_filtered_params)
      render json: @model
    else
      render json: @model.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def filtered_params
    params.permit(model_klass.column_names.map(&:to_sym)).to_h.select do |_key, value|
      value.present?
    end
  end

  def safe_filtered_params
    filtered_params.reject do |column_name|
      column_name == :id
    end
  end

  def initialize_model
    @model ||= model_klass.new
  end

  def model_klass
    @model_klass ||= controller_name.classify.constantize
  end

  def model
    @model ||= model_klass.find_by(filtered_params)
  end

  def models
    @models ||= model_klass.where(filtered_params)
  end
end