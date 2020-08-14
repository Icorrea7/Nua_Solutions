require 'rails_helper'

RSpec.describe 'lost script message is sent to the admin and Payment Record is created', type: :feature do
    scenario 'message is sent to the admin ' do
        visit message_path(1)
        payments = Payment.all.count
        click_link "I've lost my prescription"
        expect(Inbox.find(3).unread_messages).to eq(1)
        expect(Payment.all.count).to eq(payments + 1)
    end 
    scenario 'api fails' do
        visit message_path(1)
        click_link "I've lost my prescription"
        expect(page).to have_content("Error happend.")
    end 
    
end