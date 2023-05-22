function maximo(mapa, nivel)
    uMax = 10
    if mapa == 1
        if nivel == 3
            uMax = 8
        elseif nivel == 4
            uMax = 8
        end
    elseif mapa == 2
        if nivel == 2
            uMax = 10
        elseif nivel == 3
            uMax = 9
        elseif nivel == 4
            uMax = 10
        end
    elseif mapa == 3
        if nivel == 2
            uMax = 8
        elseif nivel == 4
            uMax = 8
        end
    elseif mapa == 4
        if nivel == 1
            uMax = 8
        elseif nivel == 3
            uMax = 8
        elseif nivel == 4
            uMax = 10
        end
    end
    return uMax
end

function Colisao(X, Y, CaveirasX, CaveirasY)
    for i in CaveirasX
        if (i - 0.1 <= X <= i + 0.1)
            for j in CaveirasY
                if (j - 0.1 <= Y <= j + 0.1)
                    return true
                end
            end
        end
    end
    return false
end
