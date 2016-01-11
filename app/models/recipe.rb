class Recipe < ActiveRecord::Base
  has_many :items
  has_many :directions
  belongs_to :user

  accepts_nested_attributes_for :items,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true

  validates :title, :description, :image, presence: true

  has_attached_file :image, styles: { medium: "400x400#", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
