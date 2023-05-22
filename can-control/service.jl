include("land_maps.jl")
include("aux_params.jl")

function distance(obj_p, tar_q)
    return sqrt((obj_p[1] - tar_q[1])^2 + (obj_p[2] - tar_q[2])^2)
end

function split_params(params::Vector)
    game = params[1]
    land = params[2]
    level = params[3]
    obj_ps = params[4:5]
    tar_ps = params[6:7]
    box = []
    [push!(box, params[i:i+1]) for i in 8:13]

    return game, land, level, obj_ps, tar_ps, box
end

function find_best(obj, target, land, level)
    best_dist::Int = Inf
    best_sign::Float32 = 0.0
    min_value::Float32 = -1.0
    max_value::Float32 = 1.0
    Δ::Float32 = 0.03
    #max_value = maximo(land, level)

    for i in range(-min_value, max_value, step=1)
        u_value = i / max_value
        min_dist = Inf
        distance = Inf
        p = copy(obj)
        u = u_value
    
        for q in eachindex(ObjetivosX)
            f = q == 1 ? 1 : 2
            distance = f * distance(p, target)
            if distance < min_dist
                min_dist = distance
            end
        end
            
        l12 = map_position(land, level, p, u)
        p[1] += l12[1] * Δ
        p[2] += l12[2] * Δ
        
        if min_dist < best_dist
            best_dist = min_dist
            best_sign = u_value
        end

        for j in range(-min_value, max_value, step=1)
            valorUJ = j / max_value
            p[1] = p[1]
            p[2] = p[2]
            u = valorUJ
            
            for k in 1:quant
                for q in eachindex(ObjetivosX)
                    f = q == 1 ? 1 : 2
                    distance = f * distance(p, target)
                    if distance < min_dist
                        min_dist = distance
                    end
                end
                
                l12 = map_position(land, level, p, u)
                p[1] += l12[1] * Δ
                p[2] += l12[2] * Δ
                
                if min_dist < best_dist
                    best_dist = min_dist
                    best_sign = u_value
                end
            end
        end
    end

    return best_sign
end
