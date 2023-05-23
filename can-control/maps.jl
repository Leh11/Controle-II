
linear = (level, ps, u) -> (
    if level == 1
        return [-5.2*ps[1] + 2.5*ps[2] + 3.2*u, -9*ps[1] - 0.8*ps[2] + 5.0*u]
    elseif level == 2
        return [5.0*ps[2], - 9.0*ps[1] - 0.9*ps[2] + 5*u]
    elseif level == 3
        return [-1.2*ps[1] + 2.0*ps[2], 3.6*ps[1] - 0.4*ps[2] - 5*u]
    elseif level == 4
        return [1.0*ps[1] - 0.4*ps[2] + 0.6*u, 1.8*ps[1] + 0.2*ps[2] - 5.0*u]
    end
)

non_linear = (level, ps, u)->(
    if level == 1
        return [3*ps[2] + u, -3*sin(8*ps[1]) - ps[2]]
    elseif level == 2
        return [2*ps[2] - 2*ps[1] + atan(3*ps[1]) + 2*u, 2*ps[1] - 2*ps[2]]
    elseif level == 3
        return [3*ps[1]*(0.5*ps[1] + 1.5*ps[2]) + 2.0*u, 3*(ps[1]-ps[2]) + u*u]
    elseif level == 4
        return [-10*(ps[1]-0.7)*(ps[1]+0.7) + 5.0*u, -ps[2] + 2*u]
    end
)

switchland = (level, ps, u)->(
    if level == 1
        ps .*= 10
        u *= 5
        A = [0 1; -0.4 -0.4]
        B = [0.5, 0.6]

        if ps[1] > ps[2]
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2] + B[1] * u + 3
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + B[2] * u
        else
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2] + B[1] * u - 3.0
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + B[2] * u
        end

        [p/3, q/3]
    elseif level == 2
        A = [0 -1; -0.25 0]

        if ps[1] > ps[2]
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2]
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + 2 * u
        else
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2]
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] - 2 * u
        end
        [p, q]
    elseif level == 3
        ps .*= 10
        u *= 5
        A = [0 -2.5; 2.5 0]

        if ps[1] > ps[2]
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2]
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + 4 + u
        else
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2]
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] - 4 + u
        end

        return [p/4, q/4]
    elseif level == 4
        ps .*= 10
        u *= 5
        A = [0.7578 -1.9796; 1.7454 -0.3350]
        B = [0.1005, -2.1600]
        V = [-0.1582, 1.8467]
        a = 1.2759

        if (V[1] * ps[1] + V[2] * ps[2]) > 0
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2] + a * B[1] * u
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + a * B[2] * u
        else
            p = A[1, 1] * ps[1] + A[1, 2] * ps[2] - a * B[1] * u
            q = A[2, 1] * ps[1] + A[2, 2] * ps[2] - a * B[2] * u
        end

        return [p/6, q/6]
    end
)

quantized = (level, ps, u) -> (
    if level == 1
        ps .*= 10
        u *= 5

        A = [0 1; -0.5 -0.5]
        B = [0.5, 0.8]

        p = A[1, 1] * ps[1] + A[1, 2] * ps[2] + B[1] * u
        q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + B[2] * u

        p = p > 0 ? 4 : -4
        q = q > 0 ? 4 : -4

        return [p/5, q/5]
    elseif level == 2
        ps .*= 10
        u *= 5

        A = [0 -1; 1 0]
        B = [0, 1]

        p = A[1, 1] * ps[1] + A[1, 2] * ps[2] + B[1] * u
        q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + B[2] * u

        if(p > 0 && p < 2); p = 2 end
        if(p < 0 && p > -2); p = -2 end
        if(p > 2); p = 4 end
        if(p < -2); p = -4 end  
        if(q > 0 && q < 2); q = 2 end
        if(q < 0 && q > -2); q = -2 end   
        if(q > 2); q = 4 end
        if(q < -2); q = -4 end

        return [p/5, q/5]
    elseif level == 3
        ps .*= 10
        u *= 5

        A = [0 1; 1 0]
        B = [0, 2]

        p = A[1, 1] * ps[1] + A[1, 2] * ps[2] + B[1] * u
        q = A[2, 1] * ps[1] + A[2, 2] * ps[2] + B[2] * u

        if(p > 0 && p < 2); p = 2 end
        if(p < 0 && p > -2); p = -2 end
        if(p > 2); p = 4 end
        if(p < -2); p = -4 end
        if(q > 0 && q < 2); q = 2 end
        if(q < 0 && q > -2); q = -2 end
        if(q > 2); q = 4 end    
        if(q < -2); q = -4 end
        return [p/5, q/5]
    elseif level == 4
        ps .*= 10
        u *= 5

        p = ps[2] + u
        q = -(9.8/1.0) * sin(ps[1]) - 0.1 * ps[2]

        p = p > 0 ? 2 : -2
        q = q > 0 ? 2 : -2

        return [p/5, q/5]
    end
)
