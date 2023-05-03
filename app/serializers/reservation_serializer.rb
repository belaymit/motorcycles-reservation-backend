class ReservationSerializer < ActiveModel::Serializer
  belongs_to :motorcycle
  attributes :id, :start_date, :end_date
end
