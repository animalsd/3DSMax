macroScript ShrinkLoop
category: "PolyBoost"
tooltip: "ShrinkLoop"
icon:#("PB_Icons1", 6)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBShrinkLoop $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
                                                        xecute do (
		try(
			FranticParticles.setProperty "EnableDepthOfField" ((not (FranticParticles.getBoolProperty "EnableDepthOfField")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
