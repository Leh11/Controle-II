include("maps.jl")

global time0::Float32 = 0.0;
time1::Float32 = 0.0;

function normalize(value, obj_ps, tar_ps, land, level)    
    dump, lower, upper = get_params(land, level)
    dir = quandrant(obj_ps, tar_ps)
    signal = abs(max(min(value, upper), lower))
    d = distance_1(obj_ps, tar_ps)  

    if dir == 0
        signal = d
    else
        signal = (dir * signal)
    end
    
    return signal
end

function map_position(land, level, ps, u)
    if land == 1
        linear(level, ps, u)
    elseif land == 2
        non_linear(level, ps, u)
    elseif land == 3
        switchingLand(level, ps, u)        
    elseif land == 4
        quantizedLand(level, ps, u)
    end
end

function split_params(params::Vector)
    game = params[1]
    land = params[2]
    level = params[3]
    obj_ps = params[4:5]
    tar_ps = params[6:7]
    
    return game, land, level, obj_ps, tar_ps
end

function Δpos(land, level, obj_ps, U)
    Δ::Float32 = 0.05
    positions = []

    u_size = length(U)

    push!(U, U[u_size])

    for i in 1:20
        push!(positions, obj_ps)

        t = floor(Int, u_size * i / 20) + 1

        xp = map_position(land, level, obj_ps, U[t])

        obj_ps .+= xp .* Δ
    end

    return positions
end


function test_signal(land, level, obj_ps, tar_ps)
    best_signal = 0

    min_dst = Inf
    (dump, lower, upper) = get_params(land, level)
    gen_signal = collect(lower:((abs(upper) + abs(lower)) / 15):upper)

    for i in gen_signal
        for j in gen_signal
            positions = Δpos(land, level, obj_ps, [i, j])
            aux_dst = distance_2(positions, tar_ps)

            if aux_dst < min_dst
                min_dst = aux_dst
                best_signal = i
            end
        end
    end

    return best_signal
end
