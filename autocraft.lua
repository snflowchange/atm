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

x = wrapPs("rs_bridge")
print("hei")
print(x.getAvailableExternalItemStorage())