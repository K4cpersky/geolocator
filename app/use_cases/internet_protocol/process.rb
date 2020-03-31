# frozen_string_literal: true

class InternetProtocol::Process
  def self.call(params)
    # 1. Zapisz ID
    InternetProtocol::Repository.create(params)
    # 2. Wyślij requesta po lokalizację

    # 3. Zapisz lokalizację
  end

  # @payment = Payment::CreateForm.new(payment_params)
  # @payment.submit
  # Ticket::Generate.call(
  #   tickets_ordered_amount: @payment.tickets_ordered_amount,
  #   payment_id: @payment.new_payment.id
  # )
  # Event::UpdateAvailableTickets.call(
  #   @payment.new_payment.id
  # )
  # @payment
end
