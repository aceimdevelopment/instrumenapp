class Student < User

	has_many :inscriptions, foreign_key: 'user_id'
	accepts_nested_attributes_for :inscriptions

end
