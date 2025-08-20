class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :reviews
  accepts_nested_attributes_for :questions, allow_destroy: true
  validates :title, presence: true
  validates :description, presence: true

  def to_s
    title
  end
end
