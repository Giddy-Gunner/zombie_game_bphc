love = require("love")
zombie = require("zombies")
function love.load()
    
    game = {
        state = {
            menu = false,
            running = true,
            ended = false,
        }
    }

    cursor = {
        x = 0,
        y= 0
    }
    
    love.mouse.setVisible(false)

    verydumbcursor = love.graphics.newImage("assets/reallydumbcursor.png")

    background = love.graphics.newImage("assets/BG.jpg")
    knight = {

        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
	    
	    sprite = love.graphics.newImage("8direction.png"),
        animation = {
            direction = "undefined",
            idle =false,
            frame = 1,
            max_frames_x = 4,
            max_frames_y = 8,
            max_frames = 4,
            speed = 6.5,
            timer = 0.1,
        }
    
    }

    zombies = {}

    table.insert(zombies,1,zombie())
    
    sprite_width= 128*5 
    sprite_height = 256*5


    quad_width = 32*5
    quad_height = 32*5

    --love.graphics.newQuad(0,0,quad_width,quad_height,sprite_width,sprite_height)

    quad = {}

end

function love.update(dt)
    cursor.x,cursor.y = love.mouse.getPosition()

    if love.keyboard.isDown("w") then
        knight.y = knight.y - knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "up"
        for i = 1, 4 do
            quad[i]=love.graphics.newQuad((quad_width*(i-1)),160*5,quad_width,quad_height,sprite_width,sprite_height)
        end
    end
    if love.keyboard.isDown("s") then
        knight.y = knight.y + knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "down"
        for i = 1, 4 do
            quad[i]=love.graphics.newQuad((quad_width*(i-1)),0,quad_width,quad_height,sprite_width,sprite_height)
        end
    end
    if love.keyboard.isDown("a") then
        knight.x = knight.x - knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "left"
        for i = 1, 4 do
            quad[i]=love.graphics.newQuad((quad_width*(i-1)),96*5,quad_width,quad_height,sprite_width,sprite_height)
        end
    end
    if love.keyboard.isDown("d") then
        knight.x = knight.x + knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "right"
        for i = 1, 4 do
            quad[i]=love.graphics.newQuad((quad_width*(i-1)),128*5,quad_width,quad_height,sprite_width,sprite_height)
        end
    end


    if not love.keyboard.isDown('w', 'a', 's', 'd') then
        knight.animation.idle = true
        knight.animation.frame = 1
    end

    for p = 1, #zombies do
        zombies[p]:move(knight.x,knight.y)
    end


  




    if not knight.animation.idle then
        knight.animation.timer = knight.animation.timer + dt

        if knight.animation.timer > 0.2 then
            knight.animation.timer = 0.1
            knight.animation.frame = knight.animation.frame + 1
            if knight.animation.frame > knight.animation.max_frames then
                knight.animation.frame = 1
            end
        end

    end

    if knight.x >= love.graphics.getWidth() then
        knight.x = 0
    end
    if knight.x < 0 then
        knight.x = love.graphics.getWidth()
    end
    if knight.y >= love.graphics.getHeight() then
        knight.y = 0
    end
    if knight.y < 0 then
        knight.y = love.graphics.getHeight()
    end






end


function love.draw()

    

    if game.state["menu"] then
        love.graphics.draw(verydumbcursor, cursor.x, cursor.y)
    end


    if game.state["running"] then
            
        love.graphics.scale(1)
        for i = 0, love.graphics.getWidth() / background:getWidth() do
            for j = 0, love.graphics.getHeight() / background:getHeight() do
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
            end
        end

        for k = 1, #zombies do
            zombies[k]:draw()
        end
        
        
        
        love.graphics.scale(1)
        if knight.animation.direction == "right" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x,knight.y)
        end
        if knight.animation.direction == "left" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x+quad_width,knight.y, 0, 1, 1, quad_width, 0)   
        end
        if knight.animation.direction == "up" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x+quad_width,knight.y, 0, 1, 1, quad_width, 0)   
        end
        if knight.animation.direction == "down" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x+quad_width,knight.y, 0, 1, 1, quad_width, 0)   
        end
        love.graphics.scale(1)

        love.graphics.circle("fill",knight.x,knight.y,2)


        


       
        
        fps = love.timer.getFPS( )
        love.graphics.setColor(0,0,0)
        
        

        love.graphics.rectangle("fill",0,0,120,30)
        love.graphics.rectangle("fill",1060,0,250,30)
        love.graphics.setColor(1,1,1)
        love.graphics.print("FPS: "..fps , love.graphics.getWidth()-50, 0)
        love.graphics.print("X:"..knight.x..",",10,10)
        love.graphics.print("Y:"..knight.y,65,10)
    
        love.graphics.print("sprite_frame: "..knight.animation.frame , love.graphics.getWidth()-200, 0)
        love.graphics.setColor(1,1,1)
        love.graphics.scale(1)
    end
        


   
end
