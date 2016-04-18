--[[ 
	By: Scott Harrison 
	Date: Nov 22 2015
	Updated: April 17 2016
	Verison:1.1 (nesting removed)
]]--
 
local M = {}

	local json = require("json")
	function M.loadShape( name ,fileName , myObj, friction, density, bounce, filter ,directory)
		local tempDirectory = directory
		local tempFriction
		local tempDensity
		if (friction == nil) then
			tempFriction = 0.3
		else
			tempFriction = friction
		end
		if (density == nil) then
			tempDensity = 1
		else
			tempDensity = density
		end
		if (bounce == nil) then
			tempBounce = .2
		else
			tempBounce = bounce
		end
		local tempTable = {}
		local tempTable2 = {}
		local tempTable3 = {}
		local tempTable4 = {}
		local tempTable5 = {}
		local tempTable6 = {}
		local tempX = 0
		local tempY = 0
		if (tempDirectory == nil) then
			tempDirectory = system.ResourceDirectory
		end
		local path = system.pathForFile( fileName ,directory )

		local file, errorString = io.open( path, "r" )
		if not file then
		    -- Error occurred; output the cause
		    print( "File error: " .. errorString )
		else
		    -- Read data from file
		    local contents = file:read( "*a" )
		    
		    --print( contents )

		    tempTable = json.decode( contents )

		    io.close( file )
		end
		file = nil
		if (tempTable ~= nil) then
			local tempNum
			tempTable = tempTable["rigidBodies"]
			for i=1,#tempTable do
				tempTable6 = tempTable[i]
				if (tempTable6.name == name) then
					tempNum = i
				end
			end
			if (tempNum == nil) then
				print( "Physics Body Plugin error name does not exist" )
			end
			tempTable = tempTable[tempNum]["polygons"]
			for i=1,#tempTable do
				tempTable2 = tempTable[i]
				tempTable5[i] = {}
				for j=1,#tempTable2 do
					tempTable3 = tempTable2[j]
					tempX = ((tempTable3.x))/(1/myObj.width) -myObj.width*.50
					tempY = ((tempTable3.y)*-1)/(1/myObj.height) + myObj.height*.50
					table.insert( tempTable5[i], tempX )
					table.insert( tempTable5[i], tempY )
				end
				if (filter == nil) then
					tempTable4[i] = {pe_fixture_id = "",friction=tempFriction, density=tempDensity, bounce=tempBounce, shape= tempTable5[i] }
				else
					tempTable4[i] = {pe_fixture_id = "",friction=tempFriction, density=tempDensity,  bounce=tempBounce, shape= tempTable5[i], filter = filter }
				end
			end
		end
		return unpack(tempTable4)
	end
return M