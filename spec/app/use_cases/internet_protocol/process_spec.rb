# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe InternetProtocol::Process do
  describe '.call' do
    subject(:call) { described_class.call(params) }

    let(:params) do
      { name: internet_protocol }
    end
    let(:internet_protocol) { "66.249.69.123" }

    it 'calls payment create form' do
      expect(InternetProtocol::Repository)
        .to receive(:create)
        .with(params)
        .and_call_original

      call
    end

    # it 'submits payment form' do
    #   expect_any_instance_of(Payment::CreateForm)
    #     .to receive(:submit)
    #     .and_call_original
    #
    #   call
    # end

    # it 'create tickets' do
    #   # TODO: How should I know what will be id of payment? It's 3 but should be assigned to sth.
    #   expect(Ticket::Generate)
    #     .to receive(:call)
    #     .with(tickets_ordered_amount: tickets_ordered_amount, payment_id: 3)
    #     .and_call_original
    #
    #   call
    # end

    # it 'updates event amount of available tickets' do
    #   # TODO: How should I know what will be id of payment? It's 4 but should be assigned to sth.
    #   expect(Event::UpdateAvailableTickets)
    #     .to receive(:call)
    #     .with(4)
    #     .and_call_original
    #
    #   call
    # end

    # it 'returns payment data' do
    #   call
    #   expect(call.new_payment.paid_amount).to eq payment_params[:paid_amount]
    #   expect(call.new_payment.user_id).to eq user.id
    #   expect(call.new_payment.event_id).to eq event.id
    #   expect(call.new_payment.currency).to eq payment_params[:currency]
    #   expect(call.new_payment.tickets_ordered_amount)
    #     .to eq payment_params[:tickets_ordered_amount]
    # end
  end
end
