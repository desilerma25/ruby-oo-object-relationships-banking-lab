class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  # @@all = []

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  # transfers start w. status pending
  # can be executed to a complete state
  # can go to a rejected status
  # completed trans can be in a reversed status

  def valid?
    # are both accts valid
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    # check is accts are vaild AND
    # sender has a bal > what theyre sending AND
    # status begins at pending (meaning it beginning)
    # if all checks out, - from sender bal, + to receiver bal
    # update status to complete
    # otherwise reject
    if valid? && sender.balance > amount && self.status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transfer
    end
  end

  def reverse_transfer
    # has the same idea as completed transfer
    # do opposite to "reverse" it
    # if accts are vaild AND
    # receiver bal is > amount being reversed AND
    # status is complete (b/c reversing a completed transfer)
    # remove amt from receiver
    # remove amt from sender (giving it back to receiver)
    # update status to reversed
    # otherwise reject it 
    if valid? && receiver.balance > amount && self.status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      reject_transfer
    end

  end

  def reject_transfer
    # update status to rejected
    # tell user what happened
    self.status =  "rejected"
    "Transaction rejected. Please check your account balance."
  end

end
