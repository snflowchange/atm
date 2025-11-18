-- Wrap peripheral(s) by type
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
        return periTab, sideTab
    else
        return nil
    end
end

-- Title
label = "AutomaticAutocraft"

-- ME Bridge
me = wrapPs("rsBridge")[1]
-- Monitor
mon = wrapPs("monitor")[1]

-- Item list {Display name, ME ID, minimum amount}
meItems = {
    { "Oak Planks", "minecraft:oak_planks", 100 }
}

-- Draw centered text
function CenterT(text, line, txtback , txtcolor, pos)
    local monX, monY = mon.getSize()
    mon.setBackgroundColor(txtback)
    mon.setTextColor(txtcolor)

    local length = #text
    local x = math.floor((monX - length) / 2)

    if pos == "head" then
        mon.setCursorPos(x + 1, line)
    elseif pos == "left" then
        mon.setCursorPos(2, line)
    elseif pos == "right" then
        mon.setCursorPos(monX - length, line)
    end

    mon.write(text)
end

-- Clear and draw title
function clearScreen()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    mon.setCursorPos(1,1)
    CenterT(label, 1, colors.black, colors.white, "head")
end

-- Check one item
function checkMe(checkName, displayName, low)
    local craftables = me.getCraftables()

    for _, entry in ipairs(craftables) do
        local item = entry.fingerprint
        local ItemName = item.id
        local size = item.count or 0

        if ItemName == checkName then
            row = row + 1
            CenterT(displayName, row + 1, colors.black, colors.lightGray, "left")

            if size < low then
                CenterT(size .. "/" .. low, row + 1, colors.black, colors.red, "right")

                if not me.isItemCrafting({ name = ItemName }) then
                    local missing = low - size
                    me.craftItem({ name = ItemName }, missing)
                    print("Craft " .. missing .. " " .. displayName)
                end
            else
                CenterT(size .. "/" .. low, row + 1, colors.black, colors.green, "right")
            end
        end
    end
end

-- Check all items
function checkTable()
    row = 1
    clearScreen()

    for _, item in ipairs(meItems) do
        checkMe(item[2], item[1], item[3])
    end
end

-- Main loop
while true do
    checkTable()
    sleep(3)
end
