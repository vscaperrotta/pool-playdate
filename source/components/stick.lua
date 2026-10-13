local function drawStick(angle, pivotX, pivotY, load)
  local stickLength = 200
  local stickWidth = 5
  local tipWidth = 5
  local tipHeight = 10

  local fulcroX, fulcroY = tipWidth / 2, tipHeight / 2

  local radians = math.rad(angle)
  local sine = math.sin(radians)
  local cosine = math.cos(radians)

  local function rotate(x, y)
    local relativeX = x - fulcroX
    local relativeY = y - fulcroY
    local rotatedX = pivotX + relativeX * cosine - relativeY * sine
    local rotatedY = pivotY + relativeX * sine + relativeY * cosine
    return rotatedX, rotatedY
  end

  local function loading(x, y)
    return x - sine * load, y + cosine * load
  end

  local stickX1, stickY1 = loading(rotate(0, tipHeight))
  local stickX2, stickY2 = loading(rotate(stickWidth, tipHeight))
  local stickX3, stickY3 = loading(rotate(stickWidth, stickLength))
  local stickX4, stickY4 = loading(rotate(0, stickLength))

  local tipX1, tipY1 = loading(rotate(0, 0))
  local tipX2, tipY2 = loading(rotate(tipWidth, 0))
  local tipX3, tipY3 = loading(rotate(tipWidth, tipHeight))
  local tipX4, tipY4 = loading(rotate(0, tipHeight))

  -- Stick
  GFX.drawPolygon(stickX1, stickY1, stickX2, stickY2, stickX3, stickY3, stickX4, stickY4)
  -- Tip
  GFX.drawPolygon(tipX1, tipY1, tipX2, tipY2, tipX3, tipY3, tipX4, tipY4)
  GFX.fillPolygon(tipX1, tipY1, tipX2, tipY2, tipX3, tipY3, tipX4, tipY4)

  local tipCenterX, tipCenterY = loading(rotate(fulcroX, fulcroY))

  return tipCenterX, tipCenterY
end

return drawStick
