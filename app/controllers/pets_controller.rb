class PetsController < ApplicationController
  def index
    pets = Pet.all
    render json: jsonify(pet)
  end

  def show
    pet = Pet.find_by(id: params[:id])
    if pet
      render json: jsonify(pet)
    else
      # head :not_found
      render json: { errors: { pet_id: ["No such pet"] }}, status: :not_found
      # render json: {}, status: :not_found
    end
  end

  def create
    pet = Pet.new(pet_params)
    if pet.save
      render json: {id: pet.id}
    else
      render_error(:bad_request, pet.errors.messages)
    end
  end

    private

    def pet_params
      params.require(:pet).permit(:name, :age, :human)
    end

    def jsonify(pet)
      return pet.as_json(only: [:id, :name, :age, :human])
    end
  end
