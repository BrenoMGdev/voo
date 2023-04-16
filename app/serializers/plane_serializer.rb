class PlaneSerializer < ActiveModel::Serializer
  attributes :registration, :manufacturing_date, :model

  def model
    object.model.attributes.slice(
      "id",
      "description",
      "manufacturer"
    )
  end
end
