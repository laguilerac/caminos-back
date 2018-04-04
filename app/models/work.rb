class Work < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :meetings
  has_many :documents, as: :holder
  has_many :photos, as: :owner

  validates_presence_of :name,
    :description,
    :status,
    :start_date,
    :estimated_end_date,
    :budget,
    :manager,
    :name,
    :execution_plan

  validate :valid_dates

  CATEGORIES =['Servicios Públicos','Equipamiento Estatal','Vivienda','Espacios Públicos'].freeze
  STATUS =['En proceso','Finalizadas', 'Pendientes','Vencidas','Proyectadas'].freeze

  def self.status
    STATUS
  end

  def self.categories
    CATEGORIES
  end

  def valid_dates
    if start_date && estimated_end_date && (estimated_end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end

  # TO-DO: Remove this after tags implementation
  def category
    ["water", "trash", "public", "health", "energy", "sewer", "infrastructure"][rand(7)]
  end

  def category_icon
    "icons/category-#{["water", "trash", "public", "health", "energy", "sewer", "infrastructure"][rand(7)]}.svg"
  end



end
