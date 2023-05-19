
function linear(x, u, level)
    println("linear ", level)
    if level == 1.0; [-5.2*x[1] + 2.5*x[2] + 3.2*u, -9*x[1] - 0.8*x[2] + 5.0*u] end;
    if level == 2.0; [5.0*x[2], -0.9*x[2] -9.0*x[1] + 5*u] end;
    if level == 3.0; [2.0*x[2] - 1.2*x[1], -0.4*x[2] + 3.6*x[1] - 5*u] end;
    if level == 4.0; [1.0*x[1] - 0.4*x[2] + 0.6*u, 1.8*x[1] + 0.2*x[2] - 5.0*u] end;
end

function non_linear(x, u, level)
    println("non_linear ", level)  
    if level == 1.0; [3*x[1] + u, -3*sin(8*x[2]) - x[2]]end;
    if level == 2.0; [2*x[2] - 2*x[1] + atan(4*x[2]) + 2*u, 2*x[1] - 2*x[2]]end;
    if level == 3.0; [3*x[1]*(0.5*x[1] + 1.5*x[2]) + 2.0*u, 3*(x[1]-x[2]) + u*u]end;
    if level == 4.0; [-(x[1]-0.7)*(x[1]+0.7)/0.1 + 5.0*u, -x[2] + 2*u]end ;
end

#= switchingLand = (x, u, level) -> (
)
 =#
function maps(x::Vector, u, land, level)        
    if land == 1.0
        return linear(x, u, level)
    elseif land == 2.0
        return non_linear(x, u, level)
    #= elseif land == 3
        return non_linear(x, u, level)
    elseif land == 4
        return non_linear(x, u, level) =#
    end
end
