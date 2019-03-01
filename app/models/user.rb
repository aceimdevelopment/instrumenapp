class User < ApplicationRecord

	enum role: [:student, :admin]

	attr_accessor :password_confirmation

	has_many :records

	validates :id, presence: true, uniqueness: true
	validates :name, presence: true
	validates :full_name, presence: true
	validates :password, presence: true
	validates :password, confirmation: true

	before_validation :set_role


	def self.authenticate login, clave
		return User.where(id: login, password: clave).first
	end

	protected

	def set_role
		self.role ||= :student
	end

end
