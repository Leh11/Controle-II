using Dates
using HTTP.WebSockets
using Base
Δ = 0.08

mutable struct Box
    received::Vector{String}

    Box() = new([])
end

function server(control)
    received = String[]  
    controlSignal = 0.0
    WebSockets.listen("127.0.0.1", 6660) do ws
        
        while true
            sleep(Δ)
            try
                values = [!isempty(x) ? parse(Float32, x) : 0.0f0 for x in received]
                #println(values)
                if length(values) > 0 
                    controlSignal = control.step(values)
                end
                println("Send: $controlSignal") 
            
                send(ws, string(controlSignal))

                received = split(receive(ws), ",")
                #!isempty(values) && println(received)
                
            catch
                println("System is not active...")
            end
        end
    end
end
