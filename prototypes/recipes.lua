local item_prefix = "deadlock-stack-"
local recipe_prefix = "stackrecipe-"

local function transform_ingredients(ingredients)
   for _,ingredient in pairs(ingredients) do
	  if ingredient.type and ingredient.type ~= 'fluid' then
		 if data.raw.item[item_prefix..ingredient.name] and ((ingredient.amount % 5) == 0) then
			ingredient.name = item_prefix..ingredient.name
			ingredient.amount = ingredient.amount / 5
		 end
	  end
   end
end

local function has_stackable_item(ingredients)
   for _,ingredient in pairs(ingredients) do
	  if ingredient.type and ingredient.type ~= 'fluid' then
		 if data.raw.item[item_prefix..ingredient.name] and ((ingredient.amount % 5) == 0) then
			return true
		 end
	  end
   end
   return false
end

local function stackable_recipe(name)
   local recipe = data.raw.recipe[name]
   if not recipe then log("recipe "..name.." not found") return false end
   if recipe.ingredients then
	  return has_stackable_item(recipe.ingredients)
   elseif recipe.normal then
	  return has_stackable_item(recipe.normal.ingredients) and has_stackable_item(recipe.expensive.ingredients)
   end
end

local function patch_tech(old, new)
   for _,tech in pairs(data.raw['technology']) do
	  for _, effect in pairs(tech.effects or {}) do
		 if effect.type == 'unlock-recipe' and effect.recipe == old then
			tech.effects[#tech.effects + 1] = { type = 'unlock-recipe', recipe = new }
			break;
		 end
	  end
   end
end

local function create_recipe(name)
   if not stackable_recipe(name) then log("recipe "..name.." is not stackable") return end
   local stacked = table.deepcopy(data.raw.recipe[name])
   stacked.name = recipe_prefix..name
   if stacked.main_product then
	  if data.raw.fluid[stacked.main_product] then
		 stacked.localised_name = {"recipe-name.stackrecipes-stack", {"fluid-name."..stacked.main_product}}
	  else
		 stacked.localised_name = {"recipe-name.stackrecipes-stack", {"item-name."..stacked.main_product}}
	  end
   else
	  stacked.localised_name = {"recipe-name.stackrecipes-stack", {"recipe-name."..name}}
   end
   if stacked.ingredients then 
	  transform_ingredients(stacked.ingredients)
   elseif stacked.normal then
	  transform_ingredients(stacked.normal.ingredients)
	  transform_ingredients(stacked.expensive.ingredients)
   end
   data:extend({stacked})
   patch_tech(name, stacked.name)
   --log("stacked "..name.." before:")
   --log(serpent.block(data.raw.recipe[name]))
   --log("after:")
   --log(serpent.block(data.raw.recipe[stacked.name]))
end

log("Checking for stackable recipes...")

if mods["pycoalprocessing"] then
   create_recipe("bonemeal")
   create_recipe("ralesia")
   create_recipe("rich-clay")
   create_recipe("borax-washing")
   create_recipe("coal-fawogae")
   create_recipe("coke-coal")
   create_recipe("stone-distilation")
   create_recipe("log3")
   create_recipe("niobium-dust")
   create_recipe("niobium-concentrate")
   create_recipe("mukmoux-fat")
   create_recipe("niobium-plate")
   create_recipe("organics-from-wood")
   create_recipe("log6")
   create_recipe("oleochemicals")
   create_recipe("richdust-separation")
   create_recipe("bone-solvent")
   create_recipe("nas-battery")
   create_recipe("organic-solvent")
   create_recipe("aromatic-organic")
   create_recipe("making-chromium")
   create_recipe("raw-wood-to-coal")
   create_recipe("coal-dust")
   create_recipe("sand-brick")
   create_recipe("calcium-carbide")
   create_recipe("nexelit-cartridge")
   create_recipe("organics-processing")
   create_recipe("sand-casting")
   create_recipe("slacked-lime")
   create_recipe("coaldust-ash")
   create_recipe("niobium-powder")
   create_recipe("stone-to-gravel")
   create_recipe("gravel-to-sand")
   create_recipe("sulfur-crudeoil")
   create_recipe("sulfur-heavyoil")
   create_recipe("sulfur-lightoil")
   create_recipe("coal-briquette")
   create_recipe("soil-washing")
   create_recipe("sand-washing")
   create_recipe("fawogae-substrate")
   create_recipe("lime")
   create_recipe("coarse-classification")
   create_recipe("tailings-classification")
   create_recipe("co2-organics")
   create_recipe("soil-separation")
   create_recipe("tailings-separation")
   create_recipe("ash-separation")
end

if mods["pyfusionenergy"] then
   create_recipe("stone-calcination")
   create_recipe("gravel-calcination")
   create_recipe("calcinate-separation")
end

if mods["pyhightech"] then
   create_recipe("ceramic")
   create_recipe("graphite")
   create_recipe("melamine-resin")
   create_recipe("formica")
   create_recipe("silicon")
   create_recipe("powdered-phosphate-rock")
   create_recipe("heavy-n")
   create_recipe("bakelite")
   create_recipe("stone-wool")
   create_recipe("stone-wool2")
   create_recipe("carbon-dust")
   create_recipe("sodium-silicate")
   create_recipe("raw-fiber")
   create_recipe("raw-fiber2")
   create_recipe("raw-fiber3")
   create_recipe("raw-fiber4")
   create_recipe("mukmoux-fat2")
   create_recipe("mukmoux-fat3")
   create_recipe("fiber")
   create_recipe("zipir-carcass")
   create_recipe("bonemeal3")
   create_recipe("bone-briquette")
   create_recipe("rayon")
   create_recipe("collagen")
   create_recipe("coal-phenol")
   create_recipe("coarse-tar")
   create_recipe("myoglobin")
   create_recipe("saline-water")
   create_recipe("ammonia-urea")
   create_recipe("coal-dust3")
end

if mods["pyrawores"] then
   create_recipe("powdered-aluminium")
   create_recipe("aluminium-plate-1")
   create_recipe("chromium-01")
   create_recipe("molten-chromium-01")
   create_recipe("reduction-chromium")
   create_recipe("chromium-plate-1")
   create_recipe("water-saline")
   create_recipe("py-sodium-hydroxide")
   create_recipe("bonemeal-salt")
   create_recipe("mukmoux-fat-salt")
   create_recipe("glass-3")
   create_recipe("glass-4")
   create_recipe("p2s5")
   create_recipe("p2s5-2")
   create_recipe("sodium-bisulfate")
   create_recipe("sodium-sulfate")
   create_recipe("ammonium-chloride")
   create_recipe("redhot-coke")
   create_recipe("grade-2-copper")
   create_recipe("grade-1-iron-crush")
   create_recipe("grade-2-iron")
   create_recipe("molten-iron-05")
   create_recipe("crushing-quartz")
   create_recipe("powdered-quartz")
   create_recipe("sand-classification2")
   create_recipe("molten-steel")
end
