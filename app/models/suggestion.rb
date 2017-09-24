class Suggestion < ApplicationRecord

  validates :manufacturer, :presence => true
  validates :model, :presence => true

end
