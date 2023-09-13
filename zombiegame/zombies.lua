local love = require "love"

function zombie()
    return{
        level = 1,
        --zomb_sprite = love.graphics.newImage("assets/actualspritesheet.png")
        radius =20,
        temp_rad = 20,
        x = -10,
        y = -50,

        move = function (self, knight_x, knight_y )
            if knight_x - self.x > 0 then
                self.x = self.x + 1
            elseif knight_x - self.x < 0 then
                self.x = self.x - 1 
            end
            if knight_y - self.y > 0 then
                self.y = self.y + 1
            elseif knight_y - self.y < 0 then
                self.y = self.y - 1
            end

        end,

        draw = function(self)
            love.graphics.setColor(0.5,0.5,0.5)
            love.graphics.circle("fill", 10,10,100)
            love.graphics.setColor(1,1,1)
        end

    }

   
end

return zombie