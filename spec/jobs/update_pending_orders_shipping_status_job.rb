require 'rails_helper'

RSpec.describe UpdatePendingOrdersShippingStatusJob, type: :job do
  include ActiveJob::TestHelper

  before do
    @order = FactoryBot.create(:order)
    @order_delivered = FactoryBot.create(:order, status: 'delivered')
  end

  subject(:all_pending_orders) { UpdatePendingOrdersShippingStatusJob.perform_now }

  it 'should queues the job for all pending orders' do
    expect { all_pending_orders }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(Order.not_delivered.count)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end