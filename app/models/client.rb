class Client < User
  # STI -> Adds type "Client" to User table
  
  # Connects clients to their trainer
  belongs_to :trainer, class_name: "Trainer"

  # Connects a client with his trainings
  has_many :client_trainings, dependent: :destroy
  has_many :trainings, through: :client_trainings
end
