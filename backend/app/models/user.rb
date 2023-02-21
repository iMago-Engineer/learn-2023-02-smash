class User < ApplicationRecord
    has_many :battles
    def ranking
        self.battles.pluck(:rank).sum/self.battles.count.to_f
    end
    def alchohol_amount
        sum = 0
        self.battles.each do |battle|
            sum += battle.amount * battle.sake.ratio/100.0 *0.8
        end
        return sum
    end
end
