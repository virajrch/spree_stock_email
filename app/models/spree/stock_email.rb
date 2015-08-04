class Spree::StockEmail < ActiveRecord::Base

  belongs_to :variant

  validates :variant, presence: true
  validates :email, presence: true, email: true

  validate :unique_variant_email

  def self.email_exists?(variant, email)
    exists?(sent_at: nil, variant_id: variant.id, email: email)
  end

  def self.notify(variant)
    where(sent_at: nil, variant_id: variant.id).each { |e| e.notify }
  end

  def email_exists?
    self.class.email_exists?(variant, email)
  end

  def notify
    Spree::StockEmailsMailer.stock_email(self).deliver_later rescue nil
    mark_as_sent
  end

  private

  def unique_variant_email
    errors.add :user, "already registered for notifications on this product" if email_exists?
  end

  def mark_as_sent
    touch(:sent_at)
  end

end
