class ModelSerializer < ActiveModel::Serializer
  attributes :id, :description, :manufacturer, :planes

  def planes
    object.planes.map do |p|
      p.attributes.slice(
        "registration",
        "manufacturing_date"
      )
    end
  end
end
