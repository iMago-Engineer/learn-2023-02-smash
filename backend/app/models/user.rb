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
    def win_rate
        win = 0
        self.battles.each do |battle|
            if battle.rank == 1
                win += 1
            end
        end
        return (win.to_f/self.battles.count.to_f)*100
    end
end
