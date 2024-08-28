require 'rails_helper'

RSpec.describe UpdateShippingStatusJob, type: :job do
  include ActiveJob::TestHelper

  before do
    @order = FactoryBot.create(:order)
    @order_delivered = FactoryBot.create(:order, status: 'delivered')
  end

  subject(:job_1) { described_class.perform_later(@order.id) }
  subject(:job_2) { described_class.perform_now(@order.id) }

  it 'should queues the job' do
    expect { job_1 }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'should added to the critial queue' do
    expect(UpdateShippingStatusJob.new.queue_name).to eq('critical')
  end

  it 'should get the new status of the shipment' do
    perform_enqueued_jobs {
      job_1
    }
    @order.reload
    expect(@order.status).to_not eq("processing")
    expect(@order.shipment_id).not_to be_nil
  end

  it 'should send a email to notify the user' do
    expect {
      job_2
    }.to have_enqueued_job.on_queue('mailers')
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end