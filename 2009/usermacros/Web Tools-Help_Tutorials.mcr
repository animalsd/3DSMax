macroScript Help_Tutorials category:"Web Tools" tooltip:"Help in Viewport" Icon:#("Maintoolbar",73)
(
	rollout rHelpInVP "Help in Viewport" width:850 height:520
	(
		-- Create the hhctrl.ocx browser controls
		activeXControl ax "{8856F961-340A-11D0-A96B-00C04FD705A2}" pos:[5,5] --align:#center
		on rHelpInVP open do
		(
			ax.size = [840, 515]
			ax.navigate ("mk:@MSITStore:" + (getDir #help) + "\\3dsmax_t.chm::/tut_welcome_to_the_world_of_3ds_max_7.html" )			
		)
		on ax StatusTextChange txt do enableAccelerators = false
		on rHelpInVP resized size do
		(
			enableAccelerators = false
			-- resize the browser control
			rHelpInVP.ax.size = [size.x-10, size.y-5]
		)
	)
	on execute do
	(
		createDialog rHelpInVP		
				
		-- register as an extended viewport
		registerViewWindow rHelpInVP
	)
) 