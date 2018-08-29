class BillsController < ApplicationController
  before_action :set_bill, only: %i[destroy edit update]

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bills::CreateService.new(bill_params, current_user.id).call
    if @bill.persisted?
      # flash[:success] = 'Bill created.'
      # redirect_to group_bill_path(params[:group_id], @bill)
      redirect_to group_path(params[:group_id]), notice: 'Bill created'
    else
      flash.now[:alert] = 'Something went wrong.  Please check the form.'
      render :news
    end
  end

  def destroy
    if can?(:destroy, @bill)
      @bill.destroy
      redirect_to user_path(current_user), notice: 'Bill was successfully deleted'
    else
      redirect_to user_path(current_user), alert: 'Can\'t perform this operaiton!' unless can?(:destroy, @bill)
    end
  end

  def edit
    if !can?(:edit, @bill)
      redirect_to user_path(current_user), alert: 'Can\'t perform this operaiton!' unless can?(:update, @bill)
    end
  end

  def update
    if can?(:update, @bill)
      @bill.update(bill_params[:bill])
      redirect_to user_path(current_user), notice: 'Bill was succesfully updated'
    else
      redirect_to user_path(current_user), alert: 'Can\'t perform this operaiton!' unless can?(:update, @bill)
    end
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def bill_params
    params.permit(:group_id, bill: %i[id payer_id amount split_type title])
  end
end
