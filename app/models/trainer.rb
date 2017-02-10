class Trainer < User
  # Connects trainer with his clients using a self join table. Hierarchy in one table based on trainer_id
  has_many :clients, dependent: :destroy,
                    class_name: 'Client',
                    foreign_key: 'trainer_id'
                    
  # Connects trainer with his trainings
  has_many :trainings, dependent: :destroy

  # Connects trainer with his custom-made exercises
  has_many :custom_exercises, dependent: :destroy
end
