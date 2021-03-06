class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy bills]

  def index
    @groups = current_user.groups
  end

  def show; end

  def new
    @group = Group.new
  end

  def edit
    redirect_to root_path unless can?(:update, @group)
    set_group
  end

  def create
    @group = Group.new(group_params.merge(creator_id: current_user.id))
    if @group.save
      addresses = params[:user][:address].split('; ')
      addresses.each do |address|
        User.invite!({ email: address }, current_user)
        @group.users << User.find_by(email: address)
      end
      @group.users << current_user
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new, alert: 'Group couldn\'t not be created!'
    end
  end

  def update
    if @group.update(group_params) && can?(:update, @group)
      addresses = params[:user][:address].split('; ')
      addresses.each do |address|
        unless @group.users.any? { |m| m.email == address }
          User.invite!({ email: address }, current_user)
          @group.users << User.find_by(email: address)
        end
      end
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit, alert: 'Couldn\'t not update group!'
    end
  end

  def destroy
    if can?(:destroy, @group)
      @group.destroy
      redirect_to groups_path, notice: 'Group was successfully deleted.'
    else
      redirect_to @group, alert: 'Can\'t perform this operaiton!' unless can?(:destroy, User)
    end
  end

  def bills
    respond_to do |format|
      format.js
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
