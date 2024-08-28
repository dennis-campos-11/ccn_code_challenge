require "rails_helper"

RSpec.describe ShipmentMailer, type: :mailer do
  describe 'email notification' do
    let(:order) { FactoryBot.create(:order) }
    let(:mail) { described_class.with(order: order).update_shipment_status_email.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Shipment was updated!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([ENV['EMAIL']])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([ENV['GMAIL_ACCOUNT']])
    end
  end
end
