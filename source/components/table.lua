import "variables"

local function drawTable()
  local x1, y1 = 32, 32
  local x2, y2 = SCREEN_WIDTH - 32, 32
  local x3, y3 = SCREEN_WIDTH - 32, SCREEN_HEIGHT - 32
  local x4, y4 = 32, SCREEN_HEIGHT - 32
  GFX.drawPolygon(x1, y1, x2, y2, x3, y3, x4, y4)
end

return drawTable
