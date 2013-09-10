local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require "scripts.lib.ui"
local radlib = require "scripts.lib.radlib"

---------------------------------------------------------------------------------
-- BEGINNING OF VARIABLE DECLARATIONS
---------------------------------------------------------------------------------
local screen = nil

local txtHeader = nil
---------------------------------------------------------------------------------
-- END OF VARIABLE DECLARATIONS
---------------------------------------------------------------------------------

local renderHeader = function( menu )
  txtHeader = display.newText( menu.title, 10, 10, menu.theme.title.font, 28 )
  txtHeader.x = 10 + txtHeader.width/2
  txtHeader.y = 10 + txtHeader.height/2
  local color = menu.theme.title.color
  txtHeader:setTextColor( color.red, color.green, color.blue )
  screen:insert( txtHeader )
end

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function scene:createScene( event )
  screen = self.view

  renderHeader( _G.menu )
end

function scene:enterScene( event )
  print("Start loaded...")
end

function scene:exitScene( event )
  -- stop timers, sound, etc.
end

function scene:destroyScene( event )
  -- free up resources here
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
---------------------------------------------------------------------------------

return scene


