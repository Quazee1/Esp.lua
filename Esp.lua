local Players = game:GetService("Players")

local function applyHighlight(player, isHighlighted)
  local character = player.Character or player.CharacterAdded:Wait()
  local highlight = character:FindFirstChild("Highlight")
  local label = character:FindFirstChild("BillboardGui")

  if isHighlighted then
    if not highlight then
      highlight = Instance.new("Highlight")
      highlight.Parent = character
      highlight.Archivable = true
      highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      highlight.Enabled = true

      -- Get the player's team color, defaulting to white if not found
      local teamColorBrickColor = player.TeamColor or BrickColor.new("White")
      local teamColor = teamColorBrickColor.Color

      -- Use the team color for the highlight
      highlight.FillColor = teamColor
      highlight.OutlineColor = Color3.new(0, 0, 0) -- Black outline for contrast

      highlight.FillTransparency = 0.5
      highlight.OutlineTransparency = 0

      -- Create a text label above the player's head using BillboardGui
      label = Instance.new("BillboardGui")
      label.Parent = character
      label.Size = UDim2.new(2, 0, 2, 0)
      label.Adornee = character.Head
      label.StudsOffset = Vector3.new(0, 3, 0) -- Adjust offset as needed

      local textLabel = Instance.new("TextLabel")
      textLabel.Parent = label
      textLabel.Size = UDim2.new(1, 0, 1, 0)
      textLabel.Text = player.Name
      textLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text color
      textLabel.BackgroundTransparency = 1 -- Transparent background
      textLabel.TextScaled = true
      textLabel.TextStrokeColor3 = Color3.new(1, 1, 1) -- White text stroke
      textLabel.TextStrokeTransparency = 0
    else
      highlight.Enabled = true
      label.Enabled = true
    end
  else
    if highlight then
      highlight.Enabled = false
    end
    if label then
      label.Enabled = false
    end
  end
end

-- Toggle UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0.5, -50, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 100, 0, 25)
ToggleButton.Text = "Toggle Highlight"
ToggleButton.Draggable = true -- Make the button draggable

local isHighlighted = false

ToggleButton.MouseButton1Down:Connect(function()
  isHighlighted = not isHighlighted

  for _, player in pairs(Players:GetPlayers()) do
    applyHighlight(player, isHighlighted)
  end
end)

Players.PlayerAdded:Connect(function(player)
  applyHighlight(player, isHighlighted)
end)
