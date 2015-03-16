AttackStyleName = AttackRun
Data = {
  howToBreakFormation = StraightAndScatter,
  maxBreakDistance = 3000,
  distanceFromTargetToBreak = 2000,
  safeDistanceFromTargetToDoActions = 1500,
  coordSysToUse = Target,
  horizontalMin = 0.6,
  horizontalMax = 0.9,
  horizontalFlip = 1,
  verticalMin = 0.5,
  verticalMax = 0.8,
  verticalFlip = 0,
  RandomActions = {
    {
      Type = PickNewTarget,
      Weighting = 1,
    },
    {
      Type = NoAction,
      Weighting = 9,
    },
  },
  BeingAttackedActions = {
    {
      Type = PickNewTarget,
      Weighting = 6,
    },
  },
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
