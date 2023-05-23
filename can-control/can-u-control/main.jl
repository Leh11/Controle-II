include("server_base.jl")
include("params.jl")
include("services.jl")

Base.@kwdef mutable struct Control
    controlSignal = 0.0;
    Δ::Float32 = 0.01;
    time::Float32 = 0.0;
    rec_sig::Float32 = 0.0;
    rec_dist::Float32 = 0.0;
    
    check_signal = (signal, obj_ps) -> (
        rec_dist += Δ;
        d = modl(obj_ps);
        signal = round(signal, digits=2);
        if rec_sig == signal
            time += 1
        else
            time = 0           
        end;

        if time > 50 && d > 1
            time = 0
            signal = -1 * signal
        elseif time < 50
            signal = -0.5 * signal
            time = 0
        end;

        rec_sig = signal;
        return signal
    )
   
    step::Function = (received) -> (
        #println("Received: $received");

        (game, land, level, obj_ps, tar_ps) = split_params(received);
        
        (dump, lower, upper) = get_params(land, level);
        aux = 1 - dump;
        controlSignal = dump * controlSignal + test_signal(land, level, obj_ps, tar_ps) * aux;
        (controlSigna) = normalize(controlSignal, obj_ps, tar_ps, land, level);

        controlSignal = check_signal(controlSignal, obj_ps);

        if controlSignal >= 1
            controlSignal = lower / controlSignal
        elseif controlSignal <= -1
            controlSignal = upper / controlSignal
        end;
        
        #println("rec_dist: $rec_dist");
        return (controlSignal + Δ)
    )
end

control = Control()

server(control)