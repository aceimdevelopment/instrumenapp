class Student < User

	has_many :records, foreign_key: 'user_id'
	accepts_nested_attributes_for :records

end
