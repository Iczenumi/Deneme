local driftThreshold = 15.0  
local speedThreshold = 50.0  
local driftDuration = 0.5  

local lastDriftTime = 0
local isDrifting = false


function checkDrift()
    
    local speed = ac.getCarData("speed")  
    local angle = ac.getCarData("yaw")   
    local steering = ac.getCarData("steering") 

    
    if speed > speedThreshold and math.abs(angle) > driftThreshold then
        
        if not isDrifting then
            isDrifting = true
            lastDriftTime = os.clock()  
            ac.setHUDText("Drift!", 0.5, 0.9, 1.0)  
        end
    else
        
        if isDrifting then
            isDrifting = false
            if os.clock() - lastDriftTime > driftDuration then
                ac.setHUDText("", 0.5, 0.9, 1.0)  
            end
        end
    end
end


ac.addTimedCallback(checkDrift, 0.5)