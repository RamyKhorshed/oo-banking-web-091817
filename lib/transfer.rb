class Transfer
  attr_reader :sender, :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
    @@last_transfer = self
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending'
      sender.balance -= amount
      receiver.balance += amount
      if sender.valid?
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
      if @@last_transfer.status == "complete"
        sender.balance += @@last_transfer.amount
        receiver.balance -= @@last_transfer.amount
        self.status = "reversed"
      end
  end

end
