This is a template project for building a Corona app that can update its assets from the Internet.
It also demonstrates how to use Storyboard popups.

The app is a menu app for a fictional restaurant. There are three sections: Starters, Soups, and Main Dishes. There are two items under each section. Clicking on a picture shows a popup that provides more details for the selected menu item.

# Usage

To customize your app's starter content, modify starter_content/app.json and replace the images in starter_content/images.
app.json is the asset manifest file that contains the list and the URLs of your app assets.

To customize the URL from which the app downloads updates, modify the call to downloadUpdates() in the initializeGame function in loadmenu.lua.

# Credits

This code is MIT licensed, see http://developer.coronalabs.com/code/license

The sample images are from Wikimedia:
sushi.png - http://commons.wikimedia.org/wiki/File:Sushi_appetizer.jpg
croissants.png - http://commons.wikimedia.org/wiki/File:Croissants-2.jpg
fish_soup.png - http://commons.wikimedia.org/wiki/File:Riblja_juha_Ck_0608.jpg
miso_soup.png - http://commons.wikimedia.org/wiki/File:Instant_miso_soup.jpg
sunday_roast_beef.png - http://commons.wikimedia.org/wiki/File:Sunday_roast_-_roast_beef_1.jpg
steak_tatar.png - http://commons.wikimedia.org/wiki/File:Tatar-1.jpg
