Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    
    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    -- self.dy = math.random(2) == 1 and -100 or 100
    -- self.dx = math.random(-50, 50)
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
  
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    if self.y <= 0 then
        self.y = 0
        self.dy = -ball.dy
        sounds['wall_hit']:play()
    end
    if self.y >= VIRTUAL_HEIGHT - 4 then
        self.y = VIRTUAL_HEIGHT - 4
        self.dy = -self.dy
        sounds['wall_hit']:play()
    end
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end
    return true
end

function Ball:moveAndReverse(x, y)
    self.x = x
    self.y = y
    self.dx = -self.dx * 1.03

    if self.dy < 0 then
        self.dy = -math.random(10, 150)
    else
        self.dy = math.random(10, 150)
    end
end