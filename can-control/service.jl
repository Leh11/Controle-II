include("land_maps.jl")

function distance(obj_p, tar_p)
    return sqrt((obj_p[1] - tar_p[1])^2 + (obj_p[2] - tar_p[2])^2)
end

function split_params(params::Vector)
    game = params[1]
    land = params[2]
    level = params[3]
    obj_ps = params[4:5]
    tar_ps = params[6:7]

    u = rand(Float32)

    obj_ps = maps(obj_ps, u, land, level)
    println("obj_ps ", obj_ps)
    return obj_ps, tar_ps
end