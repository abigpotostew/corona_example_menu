local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require "scripts.lib.ui"
local radlib = require "scripts.lib.radlib"

---------------------------------------------------------------------------------
-- BEGINNING OF VARIABLE DECLARATIONS
---------------------------------------------------------------------------------
local screen = nil

local txtHeader = nil
local txtSectionHeaders = {}
local txtItemTitles = {}
local imgItemThumbnails = {}
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

local renderSectionHeader = function( theme, section, sectionIndex )
  local txtSectionHeader = display.newText( section.title, 0, 0, menu.theme.body.font, 24 )
  local x = 10 + txtSectionHeader.width/2
  local y = 60 + ((sectionIndex-1) * 316) + txtSectionHeader.height/2
  txtSectionHeaders[#txtSectionHeaders + 1] = txtSectionHeader
  txtSectionHeader.x = x
  txtSectionHeader.y = y
  local color = theme.body.color
  txtSectionHeader:setTextColor( color.red, color.green, color.blue )
  screen:insert( txtSectionHeader )
end

local renderSectionItems = function( theme, section, sectionIndex )
  local color = theme.body.color
  item1 = section.items[1]
  item2 = section.items[2]

  local img1 = display.newImageRect( item1.thumbnail.filename, system.DocumentsDirectory, item1.thumbnail.width, item1.thumbnail.height )
  img1.x = 202
  img1.y = 120 + ((sectionIndex-1) * 316) + img1.height/2
  img1.item = item1
  screen:insert( img1 )
  imgItemThumbnails[#imgItemThumbnails + 1] = img1

  local txt1 = display.newText( item1.title, 0, 0, menu.theme.body.font, 16 )
  txt1.x = img1.x
  txt1.y = img1.y + img1.height/2 + 20
  txt1:setTextColor( color.red, color.green, color.blue )
  screen:insert( txt1 )
  txtItemTitles[#txtItemTitles + 1] = txt1

  local img2 = display.newImageRect( item2.thumbnail.filename, system.DocumentsDirectory, item2.thumbnail.width, item2.thumbnail.height )
  img2.x = 586
  img2.y = 120 + ((sectionIndex-1) * 316) + img2.height/2
  img2.item = item2
  screen:insert( img2 )
  imgItemThumbnails[#imgItemThumbnails + 1] = img2

  local txt2 = display.newText( item2.title, 0, 0, menu.theme.body.font, 16 )
  txt2.x = img2.x
  txt2.y = img2.y + img2.height/2 + 20
  txt2:setTextColor( color.red, color.green, color.blue )
  screen:insert( txt2 )
  txtItemTitles[#txtItemTitles + 1] = txt2
end

local renderSections = function( theme, sections )
  for i,section in ipairs( sections ) do
    renderSectionHeader( theme, section, i )
    renderSectionItems( theme, section, i )
  end
end
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function scene:createScene( event )
  screen = self.view

  renderHeader( _G.menu )
  renderSections( _G.menu.theme, _G.menu.sections )
end

function scene:enterScene( event )
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


