
function get_params(land, level)
    lower::Int = -1
    upper::Int = 1
    dump::Float32 = 0.0

    if land == 1
        dump = 0.76
        if level == 1
            dump = 0.5
        elseif level == 3
            dump = 0.25
        end
    elseif land == 2
        dump = 0.55
        if level == 4
            dump = 0.6
        end

    elseif land == 3
        dump = 0.58
        if level == 2
            upper = 0.56
            lower = -0.56
        elseif level == 3
            upper = -0.34
        elseif level == 4
            lower = -0.20
        end

    elseif land == 4
        dump = 0.65
        if level == 3
            dump = 0.2
        end
    end
  
    return dump, lower, upper
end


quandrant = (obj_ps, tar_ps) -> (
    if (obj_ps[1] < tar_ps[1]) || (obj_ps[2] < tar_ps[2]);
        return 1 
    elseif (obj_ps[1] > tar_ps[1]) || (obj_ps[2] > tar_ps[2])
        return -1 
    else
        return 0
    end
)

function distance_2(positions, tar_ps)
    min_distance = Inf
  
    for obj_ps in positions
        aux_dst = ((obj_ps[1] - tar_ps[1])^2 + (obj_ps[2] - tar_ps[2])^2)

        if aux_dst < min_distance
            min_distance = aux_dst
        end
    end

    return min_distance
end

function distance_1(obj_ps, tar_ps)
    #println("Obj: $obj_ps - Tar: $tar_ps")
    if isnan(obj_ps[1]) || isnan(obj_ps[2])
        obj_ps[1] = obj_ps[2] = 0.0
    end
    aux_dst = ((obj_ps[1] - tar_ps[1])^2 + (obj_ps[2] - tar_ps[2])^2) |> sqrt

    #println("Distance: $aux_dst")
    return aux_dst
end

modl = (obj_ps) -> (
    if !isnan(obj_ps[1]) 
        return sqrt(obj_ps[1]^2 + obj_ps[1]^2)
    else
        return 0.0
    end
)
