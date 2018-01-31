--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0966df2b7fd1ceca1c72c1ba871d4af6:5397cc625fb19b5fdcdf263b1c5103e6:e5ac5e76a8d115177d000a60a4fbcb19$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- analog_bg
            x=1,
            y=1,
            width=160,
            height=160,

        },
        {
            -- analog_thumb
            x=446,
            y=165,
            width=48,
            height=48,

        },
        {
            -- btn_A
            x=325,
            y=1,
            width=80,
            height=80,

        },
        {
            -- btn_B
            x=325,
            y=83,
            width=80,
            height=80,

        },
        {
            -- btn_L
            x=407,
            y=1,
            width=80,
            height=80,

        },
        {
            -- btn_R
            x=407,
            y=83,
            width=80,
            height=80,

        },
        {
            -- btn_X
            x=1,
            y=163,
            width=80,
            height=80,

        },
        {
            -- btn_Y
            x=83,
            y=163,
            width=80,
            height=80,

        },
        {
            -- dpad
            x=163,
            y=1,
            width=160,
            height=160,

        },
        {
            -- dpad_down
            x=383,
            y=165,
            width=61,
            height=75,

        },
        {
            -- dpad_left
            x=165,
            y=163,
            width=76,
            height=61,

        },
        {
            -- dpad_right
            x=306,
            y=165,
            width=75,
            height=61,

        },
        {
            -- dpad_up
            x=243,
            y=163,
            width=61,
            height=76,

        },
    },
    
    sheetContentWidth = 495,
    sheetContentHeight = 244
}

SheetInfo.frameIndex =
{

    ["analog_bg"] = 1,
    ["analog_thumb"] = 2,
    ["btn_A"] = 3,
    ["btn_B"] = 4,
    ["btn_L"] = 5,
    ["btn_R"] = 6,
    ["btn_X"] = 7,
    ["btn_Y"] = 8,
    ["dpad"] = 9,
    ["dpad_down"] = 10,
    ["dpad_left"] = 11,
    ["dpad_right"] = 12,
    ["dpad_up"] = 13,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
