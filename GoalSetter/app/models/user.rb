class User < ActiveRecord::Base
  attr_accessible :password, :token, :username
end
