macroScript UV_SpaceHorizontal
category: "PolyBoost"
tooltip: "UV SpaceHorizontal"
icon:#("PB_Icons3", 15)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do 
	(
	PolyBoost.UV_Space 0
	)
) 