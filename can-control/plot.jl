using Plots

function f(x)
    return sin(x)
end

function taylor_approximation(f, x0, x)
    df = cos(x0)
    return f(x0) + df * (x .- x0)
end

x = range(-π, π, length=100)
y = f.(x)

x0 = π/4
y_taylor = taylor_approximation.(f, x0, x)

plot(x, y, label="f(x)")
plot!(x, y_taylor, label="Taylor approximation")
scatter!([x0], [f(x0)], label="x0")
