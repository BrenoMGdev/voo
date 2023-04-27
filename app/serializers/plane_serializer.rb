class PlaneSerializer < ActiveModel::Serializer
  attributes :registration, :manufacturing_date, :model

  def model
    object.model.attributes.slice(
      "id",
      "description",
      "manufacturer"
    )
  end

  def manufacturing_date
		object.manufacturing_date.strftime("%Y-%m-%dT%H:%MZ")
	end
end
