class Post < ActiveRecord::Base
    belongs_to :user

    def total
        self.count
    end
        
end