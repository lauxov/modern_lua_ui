function weight(x)
    return x/1920*ScrW()
end

function height(y)
    return y/1080*ScrH()
end

surface.CreateFont("Inter16",{
    size=height(16),
    font="Inter",
    antialias=true
})

local panels_tab = {
    "home.png",
    "squares.png",
    "money.png",
    "diagramm.png",
    "calendar.png"
}

local gray_clr = Color(29,29,29)
local hover_clr = Color(65,105,225,10)
local light_gray = Color(167,168,171)
local purp_clr = Color(174,88,255)
local frame_bg = Material("framebg.png","noclamp smooth")

local function OpenDashboard()
    local frame = vgui.Create("EditablePanel")
    frame:SetPos(weight(345),height(204))
    frame:SetSize(weight(1229),height(671))
    frame:MakePopup()
    frame.Paint = function(self,w,h)
        surface.SetMaterial(frame_bg)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRect(0,0,w,h)
        draw.SimpleText("Dashboard Atlant Team","Inter16",weight(97),height(24),color_white)
        draw.RoundedBox(20,weight(943),height(373),weight(258),height(273),gray_clr)
    end
    local dicon =vgui.Create("DIconLayout",frame)
    dicon:SetPos(weight(97),height(65))
    dicon:SetSize(weight(809),height(581))
    dicon:SetSpaceX(weight(37))
    dicon:SetSpaceY(height(38))
    for i=1,6 do
        local panel = vgui.Create("Panel",dicon)
        if i==4 then
            panel:SetSize(weight(809),height(195))
        elseif i==5 or i==6 then
            panel:SetSize(weight(386),height(157))
        else
            panel:SetSize(weight(245),height(153))
        end
        panel.Paint = function(self,w,h)
            draw.RoundedBox(20,0,0,w,h,gray_clr)
        end
    end
    local tabs = vgui.Create("DIconLayout",frame)
    tabs:SetPos(weight(20),height(75))
    tabs:SetSize(weight(56),height(393))
    tabs:SetSpaceY(height(50))
    for i=1,#panels_tab do
        local panel = vgui.Create("DButton",tabs)
        panel:SetSize(weight(56),height(56))
        panel:SetText("")
        panel.alpha = 0
        panel.isactive = false
        panel.Paint = function(self,w,h)
            if self:IsHovered() or self.isactive then
                self.alpha = Lerp(FrameTime()*5,self.alpha,1)
            else
                self.alpha = Lerp(FrameTime()*5,self.alpha,0)
            end
            draw.RoundedBox(20,0,0,w,h,Color(hover_clr.r,hover_clr.g,hover_clr.b,hover_clr.a*self.alpha))
            surface.SetMaterial(Material(panels_tab[i]))
            surface.SetDrawColor(light_gray.r,light_gray.b,light_gray.b,255-self.alpha*255)
            surface.DrawTexturedRect(weight(14),height(14),weight(28),height(28))
            if self.alpha>0 then
                surface.SetDrawColor(purp_clr.r,purp_clr.g,purp_clr.b,self.alpha*255)
                surface.DrawTexturedRect(weight(14),height(14),weight(28),height(28))
            end
        end
        panel.DoClick = function(self)
            for _, pnl in ipairs(tabs:GetChildren()) do
                if pnl.isactive then
                    pnl.isactive = false
                    self.isactive=true
                else
                    self.isactive=true
                end
            end
        end
    end
end

concommand.Add("opendashboard",function()
    OpenDashboard()
end)