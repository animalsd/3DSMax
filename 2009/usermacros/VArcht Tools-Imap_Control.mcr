macroScript Imap_Control
 category:"VArcht Tools"  
	toolTip:"Imap Control"
	Icon:#("varcht1",3)
	-- Imap_Control
	-- By Eric Boer
	-- v 1.16
	-- 06/01/08
	

(


global remove_SVMap()
global remove_LDMap()

persistent global vrmap=".vrmap"
persistent global vrr=renderers.current
persistent global imap_pathS
persistent global imap_pathL
persistent global fullpthS
persistent global fullpthL


if (substring (vrr as string) 1 4 )=="V_Ra" then
(
	---------Saver---------------------------------------  


 fn remove_SVMap =
	(
	callbacks.removescripts id:#SVMap 
	callbacks.removescripts id:#SVMap_remove
	try
	Sact1.checked = false
	catch()
	
	)

	---------Loader---------------------------------------



 fn remove_LDMap =
	(
	callbacks.removescripts id:#LDMap 
	callbacks.removescripts id:#LDMap_remove 
	try
	Lact1.state = false
	catch()
	)
	
	

	
rollout ims_rollout "VArcht_Tools Imap Control v 1.16" width:374 height:197
(
	---------Settings-----------------------------------------------	
	groupBox grp0 "Renderer" pos:[17,8] width:325 height:165
	checkbox snglfrm "Single frame" pos:[27,44] width:110 height:21 enabled:false
	checkbox Mfrminc "Multiframe incremental" pos:[27,70] width:139 height:21 enabled:false
	checkbox Incadd "Incremental add to current map" pos:[27,96] width:177 height:21 enabled:false
	checkbox frmfile "From file:" pos:[27,143] width:110 height:21 enabled:false
	label lbl1 "Save:" pos:[21,27] width:59 height:15
	label lbl2 "Load:" pos:[21,125] width:59 height:15
	checkbox rndrimg "Don't render final image" pos:[180,140] width:129 height:20 checked:vrr.options_dontRenderImage
	Button render1 "RENDER" pos:[230,24] width:100 height:100 enabled:false
	Button abt1 "about" pos:[147,358] width:60 height:20 enabled:true

	---------Saver----------------------------------------------- 
	
	groupBox grp1 "Save Imaps" pos:[17,178] width:325 height:86
	editText edt1 "Path:" pos:[72,242] width:258 
	button setpath1 "Set Path" pos:[101,212] width:93 height:16
	checkbutton sact1 "Activate" pos:[29,196] width:60 height:42 enabled:false
	
	---------Loader----------------------------------------------
		
	groupBox grp2 "Load Imaps" pos:[17,270] width:325 height:86
	button getpath1 "Get Path" pos:[101,301] width:93 height:16
	editText edt2 "Path:" pos:[72,334] width:258 
	checkbutton lact1 "Activate" pos:[29,288] width:60 height:42 enabled:false
	
	
	
	on ims_rollout close do
		(
		remove_SVMap()
		remove_LDMap()
		)
		
	---------Ssettings------------------------------------------- 
	

	 on snglfrm changed true do
		 (
			vrr.adv_irradmap_mode = 0
			Mfrminc.checked = false
			Incadd.checked = false
			frmfile.checked = false
			render1.enabled = true
		 )
	
	 on Mfrminc changed true do
		 (
			vrr.adv_irradmap_mode = 1
			snglfrm.checked = false
			Incadd.checked = false
			frmfile.checked = false
			render1.enabled = true
		 )
	 
	 on Incadd changed true do
		 (
			vrr.adv_irradmap_mode = 4
			Mfrminc.checked = false
			snglfrm.checked = false
			frmfile.checked = false
			render1.enabled = true		
		 )

	 on frmfile changed true do
		 (
			vrr.adv_irradmap_mode = 2
			Mfrminc.checked = false
			Incadd.checked = false
			snglfrm.checked = false		
		 )		 
			 
	 on rndrimg changed true do
		 (
		 	vrr.options_dontRenderImage = rndrimg.state			
		 )	 

	 on render1 pressed do
		 (
		 max quick render
		 )
		 
		  on abt1 pressed do
		 (
		 	rollout about1 "About" 
			(
				
				group "VArcht Tools..."
				(
					label label01 "IMap Control"
					label label02 "Version 1.16 - 06/01/08" 
					label label04 "by Eric Boer"
					hyperlink label05 "http://www.varcht.net/" address:"http://www.varcht.net/" align:#center color:(color 0 0 192)
					hyperlink label06 "admin@varcht.net" address:"mailto:admin@varcht.net" align:#center color:(color 0 0 192)
					Button cls1 "close"  width:60 height:20 enabled:true
				)
					on cls1 pressed do 
						(
						DestroyDialog about1
						)				
			) 		 
		 createDialog about1 360 160
		 )
	 
	
	
	---------Saver-----------------------------------------------  
	 
	 
	 on setpath1 pressed do
		 (	
 		try
		 	(
			imap_pathS = getFilenameFile (fullpthS = getSaveFileName caption:"Open Irmap:" filename:"imap" \
			types:"irmap(*.vrmap)|*.vrmap|")
			)
		catch()
	if fullpthS != undefined then
			(
			lngths1 = (imap_pathS.count-3)			
			if (substring imap_pathS lngths1 4) == "0000" then
				(
				imap_pathS = (substring imap_pathS 1 (lngths1-1))				
				)
			edt1.text = ((getFilenamePath fullpthS + imap_pathS)+".vrmap")
			fullpthL = fullpthS
			imap_pathL = imap_pathS
			edt2.text = ((getFilenamePath fullpthS + imap_pathS)+".vrmap")
			sact1.enabled = true
			lact1.enabled = true
			)
		 )

	on sact1 changed theState do
		(
														
		if theState == true then		
			(			
			callbacks.removescripts id:#SVMap			
			saveimap = "z = ((currentTime.frame as integer) as string) \r for i = 1 to (4 - z.count) do z = \"0\" + z \r vrr.saveIrradianceMap (getFilenamePath fullpthS + imap_pathS +z+vrmap)\n"
			callbacks.addscript #postRenderFrame  saveimap id:#SVMap persistent:true			
			callbacks.addscript #postRender "remove_SVMap()" id:#SVMap_Remove
			snglfrm.enabled = true			
			Mfrminc.enabled = true			
			Incadd.enabled = true			
			frmfile.enabled = false
			frmfile.checked = false
			lact1.state = false						
			vrr.options_dontRenderImage = true
			rndrimg.checked = true
			remove_LDMap()
			)
		else
			(
			render1.enabled = false
			Incadd.checked = false
			Mfrminc.checked = false
			snglfrm.checked = false
			snglfrm.enabled = false			
			Mfrminc.enabled = false			
			Incadd.enabled = false
			vrr.adv_irradmap_mode = 0
			remove_SVMap()
			)
		 )
	 
	 on edt1 changed text do
	 (
	 	fullpthS = edt1.text
		etext = edt1.text
		edt2.text = etext
		fullpthL = edt1.text
	 )
	 
	 
	---------Loader--------------------------------------------------------  	 
	
	 on getpath1 pressed do
		 (
		 try
		 (
		 	imap_pathL = getFilenameFile (fullpthL = getOpenFileName caption:"Open Irmap:" filename:"imap" \
			types:"irmap(*.vrmap)|*.vrmap|")
		 )
		 Catch()
		 
		 if fullpthL != undefined then
		 	(
			lngths2 = (imap_pathL.count-3)
			if (substring imap_pathL lngths2 4) == "0000" then
				(
				imap_pathL = (substring imap_pathL 1 (lngths2-1))				
				)
			edt2.text = ((getFilenamePath fullpthL + imap_pathL)+".vrmap")
			lact1.enabled = true
			)
		)
																			
	on lact1 changed theState do
	(
		if theState == true then
			(
			callbacks.removescripts id:#LDMap 			
			loadimap = "z = ((currentTime.frame as integer) as string) \r for i = 1 to (4 - z.count) do z = \"0\" + z \r vrr.loadIrradianceMap (getFilenamePath fullpthL+imap_pathL+z+vrmap)\n"
	
			callbacks.addscript #preRenderFrame  loadimap id:#LDMap	persistent:true
			callbacks.addscript #postRender "remove_LDMap()" id:#LDMap_Remove
	 		frmfile.enabled = false		
			frmfile.checked = true
			snglfrm.enabled = false		
			Mfrminc.enabled = false
			Incadd.enabled = false
			snglfrm.checked = false		
			Mfrminc.checked = false
			Incadd.checked = false			
			vrr.adv_irradmap_mode = 2
			vrr.options_dontRenderImage = false
			rndrimg.checked = false
			render1.enabled = true
			Sact1.state = false
			remove_SVMap()
			)
		else
			(
	 		frmfile.enabled = false		
			frmfile.checked = false			
			render1.enabled = false			
			vrr.adv_irradmap_mode = 0
			remove_LDMap()
			)
	)		
	
		 on edt2 changed text do
	 (
	 	fullpthL = edt2.text		
	 )
	 

	 
	)
	
	
	


	if ims_rollout != undefined then DestroyDialog ims_rollout
	createDialog ims_rollout 360 380
	
	
)

else
(
messagebox "    vray not loaded 
Please make vray the
   current renderer"	
)
) 