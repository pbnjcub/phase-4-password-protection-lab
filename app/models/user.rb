class User < ApplicationRecord
    has_secure_password

    attribute [:username, :password, :password_confirmation]
end
