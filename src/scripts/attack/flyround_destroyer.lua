AttackStyleName = FlyRound
Data = {
  howToBreakFormation = StraightAndScatter,
  axisRotation = 5,
  maxAxisRotation = 20,
  circleSegmentAngle = 30,
  angleVariation = 0.2,
  circleHeight = -300,
  distanceFromTarget = 3000,
  distanceVariation = 0.1,
  percentChanceOfCutting = 5,
  minSegmentsToCut = 1,
  maxSegmentsToCut = 1,
  RandomActions = {
    {
      Type = PickNewTarget,
      Weighting = 1,
    },
    {
      Type = InterpolateTarget,
      Weighting = 500,
    },
    {
      Type = NoAction,
      Weighting = 5000,
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
  BeingAttackedActions = {},
  FiringActions = {
    {
      Type = InterpolateTarget,
      Weighting = 500,
    },
  },
}
