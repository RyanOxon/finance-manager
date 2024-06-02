class Billing < ApplicationRecord

  validates :emission, :expire, :identification, :amount, :category, presence: true
  validate :emission_cannot_be_future
  validate :expire_cannot_be_before_emission

  enum status: {open: 0, expired: 1, paid: 2}
  enum category: {operational: 0, personnel:1, marketing: 2, product_buy: 3, others: 10} 

  def humanized_status
    I18n.t("activerecord.attributes.billing.statuses.#{self.status}")
  end

  def self.humanized_category_name(category)
    I18n.t("activerecord.attributes.billing.categories.#{category}")
  end

  protected
  def emission_cannot_be_future
    if emission.present? && emission > Date.today
      errors.add(:emission, "não pode ser futura")
    end
  end

  def expire_cannot_be_before_emission
    if expire.present? && emission.present? && expire < emission
      errors.add(:expire, "não pode ser anterior a Data de Emissão")
    end
  end 
end
