           -- This Script was made by A1_exe's Asset to Script Converter --
----------------------] Made by: A1_exe and darkelementallord [-----------------------
				   -- * MESSAGE ME ANY PROPERTIES I'VE MISSED * --
		 -- https://www.roblox.com/messages/compose?recipientId=46695416 --

CreateInstance = function()
	------ ERROR MAGIC ------
	local __ERROR__ = Instance.new('BindableEvent')
	__ERROR__['Event']:Connect(error)
	
	--------- CREATE FUNCTION ---------
	local Create = function(class, parent)
		local Inst = Instance.new(class)
		Inst.Parent = parent
		return setmetatable({}, {
			__metatable = Inst;
			__call = function(self, Props)
				for Name, Val in next, (Props) do
					local Set, Ret = pcall(function()
						Inst[Name] = Val
					end)
					
					if not Set then
						__ERROR__:Fire('[ERROR]:- Failed to set ' .. Name .. ' on ' .. tostring(Inst))
					end
				end
				
				return Inst
			end
		})
	end
	
	-------------------------------------
	-------------------------------------
	-- SOME THINGS MAY BE OUT OF ORDER --
	----(INSTANCE RELATED PROPERTIES)----
	-------------(UNLIKELY)--------------
	-------------------------------------
	-------------------------------------

	local Main = Create('ScreenGui'){}
	
	local Frame = Create('Frame', Main){
		AnchorPoint = Vector2.new(0.5, 0.5);
		BorderSizePixel = 0;
		Size = UDim2.new(0.161442012, 0, 0.101010099, 0);
		BorderColor3 = Color3.new(0, 0, 0);
		BackgroundTransparency = 1;
		Position = UDim2.new(0.912486911, 0, 0.0707070678, 0);
		BackgroundColor3 = Color3.new(1, 1, 1)
	}
	
	local TextLabel = Create('TextLabel', Frame){
		TextWrapped = true;
		BorderSizePixel = 0;
		TextScaled = true;
		BackgroundColor3 = Color3.new(1, 1, 1);
		AnchorPoint = Vector2.new(0.5, 0.5);
		TextSize = 14;
		Size = UDim2.new(1.184466, 0, 1, 0);
		Name = "Eggs";
		BorderColor3 = Color3.new(0, 0, 0);
		Text = "🥚 %s Eggs Per %s";
		BackgroundTransparency = 1;
		Position = UDim2.new(0.407766998, 0, 0.5, 0);
		TextColor3 = Color3.new(1, 1, 1)
	}
	
	local UIAspectRatioConstraint = Create('UIAspectRatioConstraint', TextLabel){
		AspectRatio = 4.574999809265137
	}
	
	local UIStroke = Create('UIStroke', TextLabel){}
	UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
	UIStroke.Thickness = 6
	UIStroke.Color = Color3.fromRGB(26,26,26)
	
	local TextLabel1 = Create('TextLabel', Frame){
		TextWrapped = true;
		BorderSizePixel = 0;
		TextScaled = true;
		BackgroundColor3 = Color3.new(1, 1, 1);
		AnchorPoint = Vector2.new(0.5, 0.5);
		TextSize = 14;
		Size = UDim2.new(1.18469906, 0, 1, 0);
		Name = "Bubbles";
		BorderColor3 = Color3.new(0, 0, 0);
		Text = "🍬 %s Bubbles Per %s";
		BackgroundTransparency = 1;
		Position = UDim2.new(0.407883525, 0, 1.60000002, 0);
		TextColor3 = Color3.new(1, 1, 1)
	}
	
	local UIAspectRatioConstraint1 = Create('UIAspectRatioConstraint', TextLabel1){
		AspectRatio = 4.574999809265137
	}
	
	local UIStroke1 = Create('UIStroke', TextLabel1){}
	UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
	UIStroke1.Thickness = 6
	UIStroke1.Color = Color3.fromRGB(26,26,26)
	
	local UIAspectRatioConstraint2 = Create('UIAspectRatioConstraint', Frame){
		AspectRatio = 3.862499952316284
	}

	
	return Main
end

local Main = CreateInstance()

Main.Parent = game.CoreGui
Main.Name = "SecondsItemsPer"
