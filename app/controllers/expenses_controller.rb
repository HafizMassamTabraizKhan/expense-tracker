class ExpensesController < ApplicationController
  before_action :authenticate_user!
  def index
    @category = Category.find(params[:category_id])
    @expenses = @category.expenses.order(created_at: :desc)
  end

  def new
    @author = current_user
    @category = Category.find(params[:category_id])
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      if params[:expense][:category_ids].present?
        params[:expense][:category_ids].each do |category_id|
          @category = Category.find(category_id)
          @category.expenses << @expense unless @category.expenses.exists?(@expense.id)
        end
      end
      redirect_to category_path(@category), notice: 'Expenses created successfully.'
    else
      render :new, status: 422
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: [])
  end
end
