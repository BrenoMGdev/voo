class PilotSerializer < ActiveModel::Serializer
  attributes :id, :name, :abble_to_fligh

  def abble_to_fligh
    object.abble_to_fligh.map do |m|
      m.attributes.slice(
        "id",
        "description",
        "manufacturer"
      )
    end
  end
end
