class MealsController < ApplicationController
  def index
    @meals = Meal.order(eaten_at: :desc)
  end

  def create
  @meal = Meal.new(name: params[:name], eaten_at: Time.current)
  if @meal.save
    redirect_to meals_path # 保存したら一覧にリダイレクト
  else
    flash[:alert] = "記録できませんでした"
    redirect_to root_path
  end
end


  def update
    @meal = Meal.find(params[:id])
    @meal.update(meal_params)
    redirect_to meals_path
  end

  def update_all
  params[:meals].each do |meal_params|
    meal = Meal.find(meal_params[:id])
    meal.update(note: meal_params[:note])
  end
  flash[:notice] = "備考欄を保存しました"
  redirect_to meals_path
end


  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to meals_path, notice: "削除しました"
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :eaten_at, :note)
  end
end
