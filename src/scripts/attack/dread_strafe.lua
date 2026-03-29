AttackStyleName = AttackRun
Data = {
  howToBreakFormation = BreakImmediately, --ClimbAndPeelOff,
  maxBreakDistance = 4500,
  distanceFromTargetToBreak = 	1500,
  safeDistanceFromTargetToDoActions = 2000,
  coordSysToUse = Target,
  horizontalMin = 0.6,
  horizontalMax = 0.9,
  horizontalFlip = 1,
  verticalMin = 0.3,
  verticalMax = 0.7,
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
  BeingAttackedActions = {
    {
      Type = PickNewTarget,
      Weighting = 6,
    },
    {
      Type = FlightManeuver,
      Weighting = 1,
      FlightManeuverName = "RollCW",
    },
    {
      Type = FlightManeuver,
      Weighting = 1,
      FlightManeuverName = "RollCCW",
    },
  },
  FiringActions = {},
}
