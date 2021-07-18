class Transfer
    attr_accessor :sender, :receiver, :status, :amount

    def initialize(sender, receiver, amount)
        self.sender = sender
        self.receiver = receiver
        self.status = "pending"
        self.amount = amount
    end

	def valid?
		sender.valid? && receiver.valid? && self.status == "pending"
	end

	def execute_transaction
		if self.valid? && self.sender.balance >= self.amount
			self.complete_transaction
		else
			self.reject_transaction
		end
	end

	def complete_transaction
		self.sender.balance -= amount
		self.receiver.balance += amount
		self.status = "complete"
	end

	def reject_transaction
		self.status = "rejected"
		"Transaction rejected. Please check your account balance."
	end

	def reverse_transfer
		if self.status == "complete" && self.receiver.balance >= self.amount
			self.sender.balance += amount
			self.receiver.balance -= amount
			self.status = "reversed"
		end
	end
end