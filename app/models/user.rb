class User < ApplicationRecord

	# enum role: [:student, :admin]

	attr_accessor :password_confirmation

	# validates :id, presence: true, uniqueness: true
	validates :name, presence: true
	validates :last_name, presence: true
	validates :password, presence: true
	validates :password, confirmation: true

	def full_name
		"#{name} #{last_name}"
	end

	def is_admin?
		is_a? Admin
	end

	def is_student?
		is_a? Student
	end


	def self.authenticate login, clave
		return User.where(id: login, password: clave).first
	end

end
