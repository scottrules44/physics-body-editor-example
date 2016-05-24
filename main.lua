local physics = require("physics")
physics.start( )
physics.setGravity( 0, 9.8 )
local physicsBodyEditor = require("physicsBodyEditor")
local myObj = display.newImageRect( "example1.png", system.ResourceDirectory, 125, 125 )
myObj.x, myObj.y = display.contentCenterX, display.contentCenterY
physics.addBody( myObj, "static", physicsBodyEditor.loadShape("example1", "test1",myObj))

local myBox = display.newRect( display.contentCenterX-30, display.contentCenterY-100, 30, 30 )
physics.addBody( myBox, "dynamic")