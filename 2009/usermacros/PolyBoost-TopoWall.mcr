macroScript TopoWall
category: "PolyBoost"
tooltip: "TopoWall"
icon:#("PB_Icons4", 2)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.dobrick()
	)
)
