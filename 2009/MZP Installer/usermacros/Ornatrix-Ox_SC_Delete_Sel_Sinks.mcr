macroScript Ox_SC_Delete_Sel_Sinks category:"Ornatrix" tooltip:"Ox Delete Sel Sinks"
(
	scMod = OxFindSelOccurenceOf(#Ox_Surf_Comb)
	if(scMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject scMod
		scMod.DeleteSelSinks()
	)
) 