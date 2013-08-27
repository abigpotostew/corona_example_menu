local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require "scripts.lib.ui"
local radlib = require "scripts.lib.radlib"

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local screen = nil

local txtHeader = nil
local txtSectionHeaders = {}
local txtItems = {}

local renderHeader = function( menu )
  txtHeader = display.newText( menu.title.text, 10, 10, system.nativeFont, 28 )
  txtHeader.x = 10 + txtHeader.width/2
  txtHeader.y = 10 + txtHeader.height/2
  local color = menu.title.color
  txtHeader:setTextColor( color.red, color.green, color.blue )
  screen:insert( txtHeader )
end

local renderSectionHeader = function( section, sectionIndex )
  local txtSectionHeader = display.newText( section.title.text, 0, 0, system.nativeFont, 24 )
  local x = 10 + txtSectionHeader.width/2
  local y = 60 + ((sectionIndex-1) * 316) + txtSectionHeader.height/2
  txtSectionHeaders[#txtSectionHeaders + 1] = txtSectionHeader
  txtSectionHeader.x = x
  txtSectionHeader.y = y
  local color = section.title.color
  txtSectionHeader:setTextColor( color.red, color.green, color.blue )
  screen:insert( txtSectionHeader )
end

local renderSectionItems = function( section, sectionIndex )
  item1 = section.items[1]
  item2 = section.items[2]

  --local img1Filename = system.pathForFile( item1.thumbnail.filename, system.CachesDirectory )
  local img1Filename = "starter_content/images/" .. item1.thumbnail.filename
  local img1 = display.newImageRect( img1Filename, item1.thumbnail.width, item1.thumbnail.height )
  img1.x = 202
  img1.y = 120 + ((sectionIndex-1) * 316) + img1.height/2
  screen:insert( img1 )

  local img2Filename = "starter_content/images/" .. item2.thumbnail.filename
  local img2 = display.newImageRect( img1Filename, item2.thumbnail.width, item2.thumbnail.height )
  img2.x = 586
  img2.y = 120 + ((sectionIndex-1) * 316) + img2.height/2
  screen:insert( img1 )

end

local renderSections = function( sections )
  for i,section in ipairs( sections ) do
    renderSectionHeader( section, i )
    renderSectionItems( section, i )
  end
end

function scene:createScene( event )
  screen = self.view

  renderHeader( _G.menu )
  renderSections( _G.menu.sections )
end

function scene:enterScene( event )
end

function scene:exitScene( event )
end

function scene:destroyScene( event )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
--
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
---------------------------------------------------------------------------------

return scene
