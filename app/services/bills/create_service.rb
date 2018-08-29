module Bills
  class CreateService
    def initialize(params, payer_id)
      @amount = params[:bill][:amount].to_f.round(2)
      @group_id = params[:group_id]
      @payer_id = payer_id
      @title = params[:bill][:title]
      @borrowers = Group.find(group_id).users.where.not(id: @payer_id)
      @split_type = params.fetch(:split_type, 'equal')
    end

    def call
      Bills::CreateDebtsService.new(bill: bill, borrowers: borrowers, amount: splitted_amount).call if bill.save
      bill
    end

    private

    attr_reader :amount, :borrowers, :group_id, :payer_id, :split_type, :title

    def bill
      @bill ||= Bill.new(
        amount: amount,
        borrowers: borrowers,
        group_id: group_id,
        payer_id: payer_id,
        split_type: split_type,
        title: title
      )
    end

    def splitted_amount
      case split_type
      when 'equal'
        amount / (borrowers.count + 1)
      end
      # handle other cases
    end
  end
end
