class SakesController < ApplicationController
    def index
        render json: Sake.all
    end
end
