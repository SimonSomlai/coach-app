class ClientTraining < ApplicationRecord
  # Join Table (clients & trainings)
  belongs_to :client
  belongs_to :training
end
