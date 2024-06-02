require 'rails_helper'

describe "User adds a new billing" do
  it "from navbar" do
    visit root_path
    within 'nav' do
      click_on 'Duplicatas'
    end
    click_on 'Registrar nova duplicata'

    expect(current_path).to eq new_billing_path
    expect(page).to have_content 'Registrar duplicata'
    expect(page).to have_field 'Data de Emissão'
    expect(page).to have_field 'Data de Vencimento'
    expect(page).to have_field 'Identificação'
    expect(page).to have_field 'Valor'
    expect(page).to have_field 'Categoria'
    expect(page).to have_button 'Criar Duplicata'
  end
  
  it "successfully" do
    visit new_billing_path

    fill_in "Data de Emissão",	with: "#{1.month.ago}"
    fill_in "Data de Vencimento",	with: "#{1.month.from_now}"
    fill_in "Identificação",	with: "Fatura de Marketing"
    fill_in "Valor",	with: "10050"
    select "Marketing", from: "Categoria"
    click_on 'Criar Duplicata'

    expect(current_path).to eq billing_path(Billing.last)
    expect(page).to have_content 'Fatura de Marketing'
    expect(page).to have_content 'Status: Aberta'
    expect(page).to have_content "Emissão: #{I18n.l(Billing.last.emission)}"
    expect(page).to have_content "Vencimento: #{I18n.l(Billing.last.expire)}"
    expect(page).to have_content 'Valor: R$ 100,50'
    expect(page).to have_content 'Categoria: Marketing'
    expect(page).to have_link 'Editar'
  end

  it "with missing params" do
    visit new_billing_path

    fill_in "Data de Emissão",	with: ""
    fill_in "Data de Vencimento",	with: ""
    fill_in "Identificação",	with: ""
    fill_in "Valor",	with: ""
    select "Operacional", from: "Categoria"
    click_on 'Criar Duplicata'

    expect(page).to have_content 'não pode ficar em branco', count: 4 

  end
  it "Emission date cannot be future" do
    visit new_billing_path

    fill_in "Data de Emissão",	with: "#{1.day.from_now}"
    fill_in "Data de Vencimento",	with: "#{1.month.from_now}"
    fill_in "Identificação",	with: "Fatura de Marketing"
    fill_in "Valor",	with: "10050"
    select "Marketing", from: "Categoria"
    click_on 'Criar Duplicata'

    expect(page).to have_content 'Data de Emissão não pode ser futura'
  end

  it "Expire date cannot be before Emission date" do
    visit new_billing_path

    fill_in "Data de Emissão",	with: "#{2.day.from_now}"
    fill_in "Data de Vencimento",	with: "#{1.day.from_now}"
    fill_in "Identificação",	with: "Fatura de Marketing"
    fill_in "Valor",	with: "10050"
    select "Marketing", from: "Categoria"
    click_on 'Criar Duplicata'

    expect(page).to have_content 'Data de Vencimento não pode ser anterior a Data de Emissão'
  end
end
