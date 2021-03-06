local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )

local radlib = require("scripts.lib.radlib")

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local DOWNLOAD_BASE_URL = "https://raw.github.com/radamanthus/corona_example_menu/master/starter_content/"
local screen = nil
local downloadedImages = 0
local imagesToDownload = 0

local copyStarterContentIfNeeded = function()
  -- copy the files only if the app.json file does not exist
  local f = system.pathForFile( "app.json", system.DocumentsDirectory )
  if not( radlib.io.fileExists( f) ) then
    print("copying starter content...")
    radlib.io.copyFile( "starter_content/app.json", system.ResourceDirectory, "app.json", system.DocumentsDirectory )
    -- copy the image files referenced in app.json to system.DocumentsDirectory
    local jsonFile = system.pathForFile( "starter_content/app.json", system.ResourceDirectory )
    local app = radlib.io.parseJson( jsonFile )
    for i, section in ipairs( app.sections ) do
      for j, item in ipairs( section.items ) do
        local thumbnailFile = system.pathForFile( "starter_content/images/" .. item.thumbnail.filename, system.ResourceDirectory )
        if radlib.io.fileExists( thumbnailFile ) then
          radlib.io.copyFile( "starter_content/images/" .. item.thumbnail.filename,
            system.ResourceDirectory, item.thumbnail.filename, system.DocumentsDirectory )
        end
        local fullImageFile = system.pathForFile( "starter_content/images/" .. item.full_image.filename, system.ResourceDirectory )
        if radlib.io.fileExists( fullImageFile ) then
          radlib.io.copyFile( "starter_content/images/" .. item.full_image.filename,
            system.ResourceDirectory, item.full_image.filename, system.DocumentsDirectory )
        end
      end
    end
  end
end

local showMenu = function()
  _G.menu = radlib.io.parseJson( system.pathForFile( "app.json", system.DocumentsDirectory ) )
  storyboard.gotoScene( "menu" )
end

local flagImageDownloadDone = function( event )
  if "ended" == event.phase then
    downloadedImages = downloadedImages + 1
    print( "Downloaded an image! Total images downloaded: " .. downloadedImages )
    local percentDone = math.ceil( 100 * downloadedImages / imagesToDownload )
    print( "Percent done: " .. percentDone .. "%" )
    progressWidget:setProgress( downloadedImages / imagesToDownload )
    if downloadedImages >= imagesToDownload then
      showMenu()
    end
  end
end

local downloadUpatedImages = function( updatedImages )
  downloadedImages = 0
  imagesToDownload = #updatedImages
  local url = ''
  for i, imageFilename in ipairs(updatedImages) do
    url = DOWNLOAD_BASE_URL .. "images/" .. imageFilename
    print("Downloading " .. url)
    network.download( url, "GET", flagImageDownloadDone, {}, imageFilename, system.DocumentsDirectory )
  end
end

local appJsonDownloadDoneListener = function( event )
  if ( "ended" == event.phase ) then
    print("Done downloading latest app.json")

    local newAppJson = radlib.io.parseJson( system.pathForFile( "app.json", system.TemporaryDirectory ) )
    local currentAppJson = radlib.io.parseJson( system.pathForFile( "app.json", system.DocumentsDirectory ) )
    print("New version: " .. newAppJson.version )
    print("Old version: " .. currentAppJson.version )
    if newAppJson.version ~= currentAppJson.version then
      print("New version!")
      radlib.io.copyFile( "app.json", system.TemporaryDirectory, "app.json", system.DocumentsDirectory )
      downloadUpatedImages( newAppJson.updatedImages )
    else
      showMenu()
    end
  end
end

local downloadUpdates = function( url )
  progressWidget = widget.newProgressView({
    left = 100, top = 450, width = 568, isAnimated = true
  })
  screen:insert( progressWidget )
  network.download( url, "GET", appJsonDownloadDoneListener, {}, "app.json", system.TemporaryDirectory )
end

function initializeGame()
  require 'init_buttons'

  math.randomseed( os.time() )

  copyStarterContentIfNeeded()

  if radlib.network.hasNetworkConnection( 'www.github.com', 80 ) then
    print( "Network connection detected, checking for updates..." )
    downloadUpdates( DOWNLOAD_BASE_URL .. 'app.json' )
  else
    print( "No network, using locally cached content..." )
    _G.menu = radlib.io.parseJson( system.pathForFile( "app.json", system.DocumentsDirectory ) )
    storyboard.gotoScene( "menu" )
  end
end

function scene:createScene( event )
  screen = self.view

  local loadingImage = display.newImageRect( "images/splash_screen.png", 480, 320 )
  loadingImage.x = display.contentWidth/2
  loadingImage.y = display.contentHeight/2
  screen:insert(loadingImage)

  initializeGame()
end

function scene:enterScene( event )
  print("Loading screen loaded...")

  storyboard.removeAll()
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

