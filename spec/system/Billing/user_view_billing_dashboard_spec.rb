require 'rails_helper'

describe "user view billing dashboard" do
  it "from navbar" do
    visit root_path
    within 'nav' do
      click_on 'Duplicatas'
    end

    expect(current_path).to eq dashboard_billings_path 
    expect(page).to have_content 'Painel Duplicatas'
  end

  it "and view the 5 lastest registered billings" do
    Billing.create!(emission: '2024-05-26', expire: '2024-06-26', identification: 'A1' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: '2024-06-26', identification: 'A2' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: '2024-06-26', identification: 'A3' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: '2024-06-26', identification: 'A4' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: '2024-06-26', identification: 'A5' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: '2024-06-26', identification: 'A6' , amount: 1000, category: 'operational')

    visit dashboard_billings_path

    expect(page).to have_content 'Ultimas Registradas'
    expect(page).to have_content 'A2'
    expect(page).to have_content 'A3'
    expect(page).to have_content 'A4'
    expect(page).to have_content 'A5'
    expect(page).to have_content 'A6'
    expect(page).not_to have_content 'A1'
  end
  
  it "and view the 5 lastest expired billings" do
    Billing.create!(emission: '2024-05-26', expire: 1.day.ago, identification: 'A1' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: 2.day.ago, identification: 'A2' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: 3.day.ago, identification: 'A3' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: 4.day.ago, identification: 'A4' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: 5.day.ago, identification: 'A5' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: 6.day.ago, identification: 'A6' , amount: 1000, category: 'operational')
    Billing.create!(emission: '2024-05-26', expire: 1.day.from_now, identification: 'A7' , amount: 1000, category: 'operational')

    visit dashboard_billings_path
    within('div#expireds') do
      expect(page).to have_content 'Vencidas: 6'
      expect(page).to have_content 'A2'
      expect(page).to have_content 'A3'
      expect(page).to have_content 'A4'
      expect(page).to have_content 'A5'
      expect(page).to have_content 'A6'
      expect(page).not_to have_content 'A1'
      expect(page).not_to have_content 'A7'
    end
  end

  
end
