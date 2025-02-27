class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :list, through: :bookmarks
  validates :title, uniqueness: true, presence: true
  validates :overview, presence: true

  before_destroy :check_for_bookmarks

  private

  def check_for_bookmarks
    if bookmarks.any?
      errors.add(:base, "Cannot delete movie with bookmarks")
      throw(:abort)
    end
  end
end
