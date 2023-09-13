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
        y=0
    }
    
    love.mouse.setVisible(false)

    verydumbcursor = love.graphics.newImage("assets/reallydumbcursor.png")

    background = love.graphics.newImage("assets/BG.jpg")
    knight = {
        x = 0,
        y = 0,
        sprite = love.graphics.newImage("assets/actualspritesheet.png"),
        animation = {
            direction = "undefined",
            idle =true,
            frame = 1,
            max_frames = 11,
            speed = 5,
            timer = 0.1

        }
    
    }

    zombies = {}

    table.insert(zombies,1,zombie())
    
    sprite_width= 1320 
    sprite_height = 80


    quad_width = 120
    quad_height = 80
    --love.graphics.newQuad(0,0,quad_width,quad_height,sprite_width,sprite_height)

    quad = {}

    for i = 1, knight.animation.max_frames do
        quad[i]=love.graphics.newQuad((quad_width*(i-1)),0,quad_width,quad_height,sprite_width,sprite_height)
    end

end

function love.update(dt)
    cursor.x,cursor.y = love.mouse.getPosition()

    if love.keyboard.isDown("w") then
        knight.y = knight.y - knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "up"
    end
    if love.keyboard.isDown("s") then
        knight.y = knight.y + knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "down"
    end
    if love.keyboard.isDown("a") then
        knight.x = knight.x - knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "left"
    end
    if love.keyboard.isDown("d") then
        knight.x = knight.x + knight.animation.speed
        knight.animation.idle = false
        knight.animation.direction = "right"
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
                knight.animation.frame = 2
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
            
        
        for i = 0, love.graphics.getWidth() / background:getWidth() do
            for j = 0, love.graphics.getHeight() / background:getHeight() do
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
            end
        end

        for k = 1, #zombies do
            zombies[k]:draw()
        end
        
        

        if knight.animation.direction == "right" then
            
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x,knight.y)
        end
        if knight.animation.direction == "left" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x,knight.y, 0, -1, 1, quad_width, 0)   
        end
        if knight.animation.direction == "up" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x,knight.y+quad_width, 3.1415, 1, 1, quad_width, 0)   
        end
        if knight.animation.direction == "down" then
            love.graphics.draw(knight.sprite, quad[knight.animation.frame],knight.x+quad_width,knight.y, 0, 1, 1, quad_width, 0)   
        end
        love.graphics.circle("fill",knight.x,knight.y,2)


        


        love.graphics.print(knight.x,40,10)
        love.graphics.print(knight.y,10,10)
        
        fps = love.timer.getFPS( )
        love.graphics.print("FPS: "..fps , love.graphics.getWidth()-50, 0)
    
        love.graphics.scale(1)
    end
        


   
end