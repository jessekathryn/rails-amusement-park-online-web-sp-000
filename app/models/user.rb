require 'pry'

class User < ActiveRecord::Base
    has_secure_password
    has_many :rides
    has_many :attractions, through: :rides
    
    def mood
        if self.nausea == nil && self.happiness == nil || self.nausea <= self.happiness
            "happy"
        else 
            "sad"
        end
    end

end

