-- Libraries
import "CoreLibs/graphics"

-- Modules
import "variables"
local drawStick = import "./components/stick.lua"
local drawTable = import "./components/table.lua"
local drawBall = import "./components/ball.lua"

-- Global state
local globalState = {
  ballNumber = 2, -- 16 for final game
  balls = {},
  stick = {
    speed = 3,
    x = 150,
    y = 100,
    loading = 0,
    loadingSpeed = 2
  },
}

for i = 1, globalState.ballNumber do
  globalState.balls[i] = {
    x = math.random(40, SCREEN_WIDTH - 40),
    y = math.random(40, SCREEN_HEIGHT - 40),
    radius = 8,
    vX = 0,
    vY = 0,
    touching = false
  }
end

-- Life cycle
function playdate.update()
  GFX.clear()

  -- Translations
  local language = playdate.getSystemLanguage()

  -- Cranck
  local crankPosition = playdate.getCrankPosition()

  local messageStart = nil

  if GAME_STATE == 0 then
    -- Game start

    if language == playdate.kLanguageEnglish then
      messageStart = TRANSLATION_EN.start
    elseif language == playdate.kLanguageJapanese then
      messageStart = TRANSLATION_JP.start
    end

    local textWidth, textHeight = GFX.getTextSize(messageStart)

    local topPosition = SCREEN_HEIGHT / 3

    GFX.drawText(messageStart, (SCREEN_WIDTH - textWidth) / 2, SCREEN_HEIGHT - topPosition)
    if playdate.buttonJustPressed(BUTTON_A) then
      GAME_STATE = 1
    end
  elseif GAME_STATE == 1 then
    drawTable()

    for _, ball in ipairs(globalState.balls) do
      ball.x = ball.x + ball.vX
      ball.y = ball.y + ball.vY

      ball.vX = ball.vX * 0.98
      ball.vY = ball.vY * 0.98
      drawBall(ball)
    end

    local tipX, tipY = drawStick(
      crankPosition,
      globalState.stick.x,
      globalState.stick.y,
      globalState.stick.loading
    )

    -- local function tipTouchesBall(tX, tY, ball)
    --   local dx = tX - ball.x
    --   local dy = tY - ball.y
    --   local contactRadius = ball.radius + 4

    --   return dx * dx + dy * dy <= contactRadius * contactRadius
    -- end

    -- Move the stick
    if playdate.buttonIsPressed(BUTTON_UP) then
      globalState.stick.y = globalState.stick.y - globalState.stick.speed
    elseif playdate.buttonIsPressed(BUTTON_DOWN) then
      globalState.stick.y = globalState.stick.y + globalState.stick.speed
    elseif playdate.buttonIsPressed(BUTTON_LEFT) then
      globalState.stick.x = globalState.stick.x - globalState.stick.speed
    elseif playdate.buttonIsPressed(BUTTON_RIGHT) then
      globalState.stick.x = globalState.stick.x + globalState.stick.speed
    end

    -- Load the stick
    if playdate.buttonIsPressed(BUTTON_A) then
      if globalState.stick.loading >= 100 then
        globalState.stick.loading = 100
      else
        globalState.stick.loading = globalState.stick.loading + globalState.stick.loadingSpeed
      end
    else
      if globalState.stick.loading > 0 then
        globalState.stick.loading = globalState.stick.loading - 33
      else
        globalState.stick.loading = 0
      end
    end

    if globalState.stick.loading > 0 and globalState.stick.loading <= 100 then
      GFX.drawText(globalState.stick.loading, 5, 5)
    elseif globalState.stick.loading > 100 then
      GFX.drawText(100, 5, 5)
    end
  end
end
