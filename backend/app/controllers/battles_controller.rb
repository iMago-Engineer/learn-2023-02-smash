class BattlesController < ApplicationController
    # before_action :set_user, only: [:create]
    # before_action :set_sake, only: [:create]
    def index
        users = User.all
        render json: users.map { |user| {name: user.name, rank: user.ranking, amount: user.alchohol_amount} }
    end

    def create
        battle_params =  params.permit(_json: [:amount, :rank, :name, :sake, :ratio]).to_h[:_json]

        puts("before")
        puts(battle_params)

        @scene = Battle.maximum(:scene)+1
        battle_params = battle_params.map do |item|
            item[:user] = User.find_or_create_by!(name:item["name"])
            item[:sake] = Sake.find_or_create_by!(name:item["sake"], ratio:item["ratio"])
            item[:scene] = @scene
            item.slice(:amount, :rank, :user, :sake, :scene)
        end

        puts("after")
        puts(battle_params)

        battle = battle_params.map{|item| Battle.create!(item)}

        render json: {message: 'success'}

    rescue => e
        render json: {message: e}
    end
end
