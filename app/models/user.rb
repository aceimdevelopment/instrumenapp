class User < ApplicationRecord

	# enum role: [:student, :admin]

	attr_accessor :password_confirmation

	validates :id, presence: true, uniqueness: true
	validates :name, presence: true
	validates :last_name, presence: true
	validates :password, presence: true
	validates :password, confirmation: true

	scope :search, lambda { |clave| 
	  where("id LIKE ? OR name LIKE ? OR last_name LIKE ? OR email LIKE ? OR phone LIKE ?","%#{clave}%","%#{clave}%","%#{clave}%", "%#{clave}%", "%#{clave}%")
	}

	def description
		"(#{id}) #{inverse_name}"
	end

	def tipo
		if type.eql? 'Student'
			return 'Estudiante'
		elsif type.eql? 'Admin'
			return 'Administrador'
		else
			return 'Usuario'
		end
	end

	def full_name
		"#{name} #{last_name}"
	end

	def inverse_name
		"#{last_name.titleize}, #{name.titleize}"
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

	protected

	def set_pw_default
		self.password ||= self.id
	end

end
