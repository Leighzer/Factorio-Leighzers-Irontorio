--hide the items
leighzermods.utils.hideItem("copper-ore")
leighzermods.utils.hideItem("stone")
leighzermods.utils.hideItem("copper-plate")
leighzermods.utils.hideItem("stone-brick")

--hide the recipes
leighzermods.utils.hideRecipe("copper-plate")
leighzermods.utils.hideRecipe("stone-brick")

--delete autoplace control from main menu
leighzermods.utils.deleteAutoplaceControl("copper-ore")
leighzermods.utils.deleteAutoplaceControl("stone")

--delete autoplace in resource entity (so ore patches do not get placed)
leighzermods.utils.deleteResourceAutoplace("copper-ore")
leighzermods.utils.deleteResourceAutoplace("stone")

--delete references to autplace control in map gen presets - avoids nil error
leighzermods.utils.deleteAutoplaceControlFromDefaultMapGenPresets("copper-ore")
leighzermods.utils.deleteAutoplaceControlFromDefaultMapGenPresets("stone")

--params for replacing ingredient (needs type and name defined)
local oldCopperOreIngredient = {type="item", name="copper-ore"}
local oldCopperPlateIngredient = {type="item", name="copper-plate"}
local oldStoneIngredient = {type="item", name="stone"}
local oldStoneBrickIngredient = {type="item", name="stone-brick"}

local newIronOreIngredient = {type="item", name="iron-ore"}
local newIronPlateIngredient = {type="item", name="iron-plate"}

--for all non smelting recipes, swap copper ore and stone requirements with iron ore + swap copper plate and stone brick requirements with iron plate
for k,v in pairs(data.raw.recipe) do
    if v.category ~= "smelting" then
        local recipeName = v.name or v[1]
        leighzermods.utils.replaceIngredientFromRecipe(recipeName,oldCopperOreIngredient,newIronOreIngredient)
        leighzermods.utils.replaceIngredientFromRecipe(recipeName,oldStoneIngredient,newIronOreIngredient)

        leighzermods.utils.replaceIngredientFromRecipe(recipeName,oldCopperPlateIngredient,newIronPlateIngredient)        
        leighzermods.utils.replaceIngredientFromRecipe(recipeName,oldStoneBrickIngredient,newIronPlateIngredient)
    end
end

--no idea how hard baked copper cable is for connecting entities together in a power network
--just going to do some small overrides to make it LOOK like iron
local copperCable = data.raw.item["copper-cable"]
copperCable.icon = "__leighzerirontorio__/graphics/icons/iron-cable.png"
copperCable.localised_name = "Iron cable"

--change power poles to have an iron looking cable
local copperWire = data.raw["utility-sprites"]["default"]["copper_wire"]
copperWire.filename = "__leighzerirontorio__/graphics/iron-wire.png"
copperWire.hr_version.filename = "__leighzerirontorio__/graphics/hr-iron-wire.png"


