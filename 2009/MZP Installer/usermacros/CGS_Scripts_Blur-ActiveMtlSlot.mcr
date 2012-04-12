macroScript ActiveMtlSlot category:"CGS-Scripts_Blur" tooltip:"ActiveMtlSlot"
	(
	-------------------------------------------------------------------------------
-- ActiveMtlSlot.ms
-- By Neil Blevins (soulburn@blur.com)
-- v 1.00
-- Created On: 04/13/01
-- Modified On: 04/13/01
-- tested using Max 4.0
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Prints the current Active Material Slot Index to the Listener.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
to_print = (medit.GetActiveMtlSlot() as string)
print to_print
)
-------------------------------------------------------------------------------
	)
