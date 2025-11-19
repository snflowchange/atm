function wrapPs(peripheralName)
    local periTab = {}
    local sideTab = {}

    if not peripheralName then
        print("Error: No peripheral name")
        return nil
    end

    for _, side in ipairs(peripheral.getNames()) do
        if string.lower(peripheral.getType(side)) == string.lower(peripheralName) then
            table.insert(periTab, peripheral.wrap(side))
            table.insert(sideTab, side)
        end
    end

    if #periTab > 0 then
        print("Found peripheral")
        return periTab, sideTab
    else
        return nil
    end
end

label = "NegerCraft"

rs = wrapPs("rs_bridge")[1]

mon = wrapPs("monitor")[1]

rsItems = {
    {"Oak Planks", "minecraft:oak_planks", 100 }
}

function CenterT(text, line, txtback, txtcolor, pos)
    local monX, monY = mon.getSize()
    mon.setBackGroundColor(txtback)
    mon.setTextColor(txtcolor)
    
    local length = #text
    local x = math.floor((monX-length)/2)
    if pos == "head" then
        mon.setCursorPos(x+1,line)
    elseif pos == "left" then
        mon.setCursorPos(2, line)
    elseif pos == "right" then
        mon.setCursorPos(monX - length, line)
    end

    mon.write(text)
end

function clearScreen()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    mon.setCursorPos(1,1)
    CenterT(label, 1, colors.black, colors.white, "head")
end

function checkRs(checkName, displayName, low)
    local craftables = rs.getCraftables()
    print(craftables)
end

print(checkRs("test", "test", "test"))


