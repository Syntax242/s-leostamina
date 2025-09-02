Config = {}

-- Jobs counted as LEO (add as many as you want)
Config.LeoJobs = {
    police = true,
    sheriff = true
}

-- Count jobs with type 'leo' as LEO automatically?
Config.ConsiderJobTypeLeo = true

-- Active only when on duty?
Config.OnlyOnDuty = true

-- Stamina regen multiplier (1.0 = normal, 2.0 = twice as fast)
Config.LeoRegenMultiplier = 2.0

-- Extra stamina per tick (0.0–1.0 recommended; stamina is 0–1)
Config.BonusRestorePerTick = 0.15

-- Interval for bonus restore while running (ms). Lower = stronger effect / more frequent.
Config.BonusRestoreInterval = 250

-- Regen multiplier for non-LEO jobs (do not change)
Config.DefaultRegenMultiplier = 1.0
