class User < ApplicationRecord
	enum type: [:student, :admin]
end