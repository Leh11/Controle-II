using Dates
using HTTP.WebSockets

Δ = 0.03

mutable struct Box
    received::Vector{String}

    Box() = new([])
end

function server(control)
    received = String[]  
    previous_error = 0.0  
    controlSignal = 0.0
    WebSockets.listen("127.0.0.1", 6660) do ws
        while true
            #sleep(Δ)
            #try
                values = [!isempty(x) ? parse(Float32, x) : 0.0f0 for x in received]
                #println(values)
                if length(values) > 0 
                    controlSignal, previous_error = control.step(values, previous_error)
                end
                    #println("Sending: $controlSignal") 
            
                send(ws, string(controlSignal))

                received = split(receive(ws), ",")
                #!isempty(values) && println(received)
                
            #= catch
                println("System is not active...")
            end =#
        end
    end
end
