class PassengerSerializer < ActiveModel::Serializer
  attributes :id, :cpf, :passport, :country, :name, :surname, :miles
end