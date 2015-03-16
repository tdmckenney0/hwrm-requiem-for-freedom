AttackStyleName = AttackRun
Data = {
  howToBreakFormation = StraightAndScatter,
  maxBreakDistance = 4000,
  distanceFromTargetToBreak = 700,
  safeDistanceFromTargetToDoActions = 1800,
  useTargetUp = 0,
  coordSysToUse = Attacker,
  horizontalMin = 0.9,
  horizontalMax = 0.9,
  horizontalFlip = 1,
  verticalMin = 0.9,
  verticalMax = 0.9,
  verticalFlip = 1,
  RandomActions = {
    {
      Type = PickNewTarget,
      Weighting = 1,
    },
    {
      Type = NoAction,
      Weighting = 2,
    },
  },
  BeingAttackedActions = {},
  FiringActions = {
    {
      Type = NoAction,
      Weighting = 13,
    },
    {
      Type = FlightManeuver,
      Weighting = 1,
      FlightManeuverName = "RollCW_slow",
    },
    {
      Type = FlightManeuver,
      Weighting = 1,
      FlightManeuverName = "RollCCW_slow",
    },
  },
}
