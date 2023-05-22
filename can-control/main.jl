include("server_base.jl")
include("aux_params.jl")
include("service.jl")

Base.@kwdef mutable struct Control
    time::Float32 = 0.0 
    Δ::Float32 = 0.03

    step::Function = (received) -> (
        (game, land, level, obj, target) = split_params(received);

        k = map_position(land, level, [0, 0], false);
        
        controlSignal = saida + k * find_best(obj, target, land, level);
        
        if abs(controlSignal) >= 1
            controlSignal = controlSignal / abs(controlSignal)
        end;
        
	    return controlSignal
    )
end

control = Control()

server(control)