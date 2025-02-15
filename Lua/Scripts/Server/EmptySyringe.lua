Hook.Add("empty_syringe_bone.onUse", function(effect, deltaTime, item, targets, worldPosition)

    -- Local Definitions
    local target = targets[1]
    local char = effect.user
    local targetType = tostring(target)

    -- Check if target is either Human or Humanhusk
    if targetType == "Human" then
        if HF.GetSkillRequirementMet(char, "medical", 50) then
            for _, limb in pairs(LimbType) do
                if HF.HasAfflictionLimb(target, "drilledbones", limb, 1) then
                    if HF.HasAfflictionLimb(target, "bonemarrowextracted", limb, 100) then return else
                    HF.AddAfflictionLimb(target, "bonemarrowextracted", limb, 10, char) -- Bone damage from harvest
                    end
                end
            end
            HF.GiveItem(char, "bone_marrow")
            HF.RemoveItem(item)
        else
            -- Failed attempt consequences
            HF.AddAfflictionLimb(target, "severepain", LimbType.Torso, 40, char) -- Excruciating pain
            HF.AddAfflictionLimb(target, "bonedamage", LimbType.Torso, 50, char) -- Bone damage risk
            HF.AddAfflictionLimb(target, "t_fracture", LimbType.Torso, 25, char) -- Potential fracture
            HF.AddAfflictionLimb(target, "internalbleeding", LimbType.Torso, 45, char) -- Internal hemorrhage
        end
    end

end)

