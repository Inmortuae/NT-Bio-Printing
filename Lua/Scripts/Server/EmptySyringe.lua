Hook.Add("empty_syringe_bone.onUse", function(effect, deltaTime, item, targets, worldPosition)

    -- Local Definitions
    local target = targets[1]
    local char = effect.user
    local targetType = tostring(target)

    -- Check if target is either Human or Humanhusk
    if targetType == "Human" then
        if HF.GetSkillRequirementMet(char, "medical", 50) then
            for _, limb in pairs(LimbType) do
                if HF.HasAfflictionLimb(target, "drilledbones", limb, 1) and not HF.HasAfflictionLimb(target, "bonemarrowextracted", limb, 100) then
                    HF.AddAfflictionLimb(target, "bonemarrowextracted", limb, 20, char) -- Bone damage from harvest
                    HF.GiveItem(char, "bone_marrow")
                    HF.RemoveItem(item)
                    print("Bone marrow extracted from limb")
                    break -- Ensures only one item is given
                end
            end
        else
            -- Failed attempt consequences (only applied once to the torso)
            local torso = LimbType.Torso
            HF.AddAfflictionLimb(target, "severepain", torso, 40, char) -- Excruciating pain
            HF.AddAfflictionLimb(target, "bonedamage", torso, 50, char) -- Bone damage risk
            HF.AddAfflictionLimb(target, "t_fracture", torso, 25, char) -- Potential fracture
            HF.AddAfflictionLimb(target, "internalbleeding", torso, 45, char) -- Internal hemorrhage
        end
    end

end)
