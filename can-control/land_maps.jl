function map_position(mapa, nivel, p, u, f::Bool=true)
    fix_const = 0.65
    l1 = 0
    l2 = 0
    
    if mapa == 1
        if nivel == 1
            fip_const = 0.25
            l1 = -5.2*p[1] + 2.5*p[2] + 3.2u
            l2 = -9.0*p[1] - 0.8*p[2] + 5.0u
        elseif nivel == 2
            fip_const = 0.5
            l1 = 5.0*p[2]
            l2 = -9.0*p[1] - 0.9*p[2] + 5.0u
        elseif nivel == 3
            fip_const = 0.25
            l1 = -1.2*p[1] + 2.0*p[2]
            l2 = 3.6*p[1] - 0.4*p[2] - 5.0u
        elseif nivel == 4
            fix_const = 0.25
            l1 = 1.0*p[1] - 0.4*p[2] + 0.6u
            l2 = 1.8*p[1] + 0.2*p[2] - 5.0u
        end
    elseif mapa == 2
        fix_const = 0.25
        if nivel == 1
            l1 = 3.0*p[2] + 1.0u
            l2 = -3.0*sin(8*p[1]) - p[2]
        elseif nivel == 2
            l1 = -2.0*p[1] + atan(4.0*p[1]) + 2.0*p[2] + 2.0u
            l2 = 2.0*p[1] - 2.0*p[2]
        elseif nivel == 3
            fix_const = 0.2
            l1 = 3.0*p[1] * (0.5*p[1] + 1.5*p[2]) + 2.0u
            l2 = 3.0 * (p[1] - p[2]) + u^2
        elseif nivel == 4
            fix_const = 0.25
            l1 = -10.0 * (p[1] - 0.7) * (p[1] + 0.7) + 5.0u
            l2 = -1.0*p[2] + 2.0u
        end
    elseif mapa == 3
        if nivel == 1
            fix_const = 0.3
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            l1 = 1.0*p[2] + 0.5u
            l2 = -0.5 * (p[1] + p[2]) + 0.8u
            if p[1] > p[2]
                l1 += 3
            else
                l1 -= 3
            end
            l1 /= 3
            l2 /= 3
        elseif nivel == 2
            fix_const = 0.3
            l1 = -1.0*p[2]
            l2 = -0.25*p[1]
            if p[1] > 0
                l2 += 2u
            else
                l2 -= 2u
            end
        elseif nivel == 3
            fix_const = 0.3
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            l1 = -1.0*p[2]
            l2 = 1.0*p[1]
            if p[1] < p[2]
                l2 += 4.0 + u
            else
                l2 -= 4.0 + u
            end
            l1 /= 4
            l2 /= 4
        elseif nivel == 4
            fix_const = 0.3
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            z = 1.2759
            l1 = 0.7578*p[1] - 1.9796*p[2]
            l2 = 1.7454*p[1] - 0.3350*p[2]
            if -0.1582*p[1] + 1.8467*p[2] > 0
                l1 += 0.1005 * z * u
                l2 -= 2.16 * z * u
            else
                l1 -= 0.1005 * z * u
                l2 += 2.16 * z * u
            end
            l1 /= 6
            l2 /= 6
        end
    elseif mapa == 4
        if nivel == 1
            fix_const = 0.8
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            l1 = 1.0*p[2] + 0.5u
            l2 = -0.5 * (p[1] + p[2]) + 0.8u
            if l1 > 0
                l1 = 4.0
            else
                l1 = -4.0
            end
            if l2 > 0
                l2 = 4.0
            else
                l2 = -4.0
            end
            l1 /= 5.0
            l2 /= 5.0
        elseif nivel == 2
            fix_const = 0.3
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            l1 = -1.0*p[2]
            l2 = 1.0*p[1] + 1.0u
            if l1 > 0.0 && l1 < 2.0
                l1 = 2.0
            end
            if l1 < 0.0 && l1 > -2.0
                l1 = -2.0
            end
            if l1 > 2.0
                l1 = 4.0
            end
            if l1 < -2.0
                l1 = -4.0
            end
            if l2 > 0.0 && l2 < 2.0
                l2 = 2.0
            end
            if l2 < 0.0 && l2 > -2.0
                l2 = -2.0
            end
            if l2 > 2.0
                l2 = 4.0
            end
            if l2 < -2.0
                l2 = -4.0
            end
            l1 /= 5.0
            l2 /= 5.0
        elseif nivel == 3
            fix_const = 0.7
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            l1 = p[2]
            l2 = p[1] + 2.0u
            if l1 > 0.0 && l1 < 2.0
                l1 = 2.0
            end
            if l1 < 0.0 && l1 > -2.0
                l1 = -2.0
            end
            if l1 > 2.0
                l1 = 4.0
            end
            if l1 < -2.0
                l1 = -4.0
            end
            if l2 > 0.0 && l2 < 2.0
                l2 = 2.0
            end
            if l2 < 0.0 && l2 > -2.0
                l2 = -2.0
            end
            if l2 > 2.0
                l2 = 4.0
            end
            if l2 < -2.0
                l2 = -4.0
            end
            l1 /= 5.0
            l2 /= 5.0
        elseif nivel == 4
            fix_const = 0.6
            p[1] = 10*p[1]
            p[2] = 10*p[2]
            u = 5u
            l1 = 1.0*p[2] + 1.0u
            l2 = -(9.8 / 1.0) * sin(p[1]) - 1.0*p[2]
            if l1 > 0
                l1 = 2.0
            else
                l1 = -2.0
            end
            if l2 > 0
                l2 = 2.0
            else
                l2 = -2.0
            end
            l1 /= 5.0
            l2 /= 5.0
        end
    end
    
    f == true && return (l1, l2)
    
    return fix_const
end
