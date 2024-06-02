class Billing < ApplicationRecord

  enum status: {open: 0, expired: 1, paid: 2}
  enum category: {operational: 0, personnel:1, marketing: 2, product_buy: 3, others: 10} 

  def humanized_status
    I18n.t("activerecord.attributes.billing.statuses.#{self.status}")
  end

  def self.humanized_category_name(category)
    I18n.t("activerecord.attributes.billing.categories.#{category}")
  end
end
