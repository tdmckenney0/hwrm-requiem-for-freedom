AttackStyleName = AttackRun
Data = {
  howToBreakFormation = StraightAndScatter,
  maxBreakDistance = 4000,
  distanceFromTargetToBreak = 2000,
  safeDistanceFromTargetToDoActions = 3000,
  useTargetUp = 0,
  coordSysToUse = TargetPoint,
  horizontalMin = 0.2,
  horizontalMax = 0.6,
  horizontalFlip = 1,
  verticalMin = 0.4,
  verticalMax = 0.7,
  verticalFlip = 0,
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
