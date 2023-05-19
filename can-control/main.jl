include("server_base.jl")
include("service.jl")
Δ = 0.01
Kp = 0.9
Ki = 0.2
Kd = 0.5
int = 0.0

Base.@kwdef mutable struct Control
    time::Float32 = 0.0    

    step::Function = (received, previous_error) -> (
        (obj_ps, tar_ps) = split_params(received);
        #print("parms", t);
        error = distance([1.0, 3.3], [1.0, 1.0]);
        pro = Kp * error;
        #int += Ki * error * Δ;
        der = Kd * (error - previous_error) / Δ;

        # Calcular o sinal de controle
        controlSignal = pro + (Ki * error * Δ) + der;

        println("Sinal: $controlSignal");
		controlSignal = sin(time);
		time += Δ;

	    return controlSignal, error
    )
end

control = Control()

server(control)
