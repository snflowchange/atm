local Pine3D = require("Pine3D")

local ThreeDFrame = Pine3D.newFrame() -- x1, y1, x2, y2 (default is fullscreen)
ThreeDFrame:setCamera(0, 0.6, 0) -- x, y, z, rotations around all axes (optional)
ThreeDFrame:setFoV(60) -- set the field of view

local objects = {
  -- args: modelId, x, y, z, rotations around all axes (optional)
  ThreeDFrame:newObject("models/pineapple", 2, 0, 0, nil, math.pi*0.25, nil),
}

ThreeDFrame:drawObjects(objects)
ThreeDFrame:drawBuffer()
sleep(1)