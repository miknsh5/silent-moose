# This imports all the layers for "NodeControls" into nodecontrolsLayers1
sketch = Framer.Importer.load "imported/NodeControls"

Utils.globalLayers(sketch)

# Setup
Framer.Defaults.Animation = 
	curve: "spring(300,30,0)"
	time: 0.2
	
# Overlay
isHome = true
isSelect = false

shadebg = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "black"
	opacity: 0.8
	
shadebg.placeBehind(artboardA)


nodeSelected.visible = true
# nodeDetailsEditBtn.visible = false

# ---------
# Define States
# ---------
shadebg.states.add
	Home: opacity: 0
	Hover: opacity: 0.8
	Select: opacity: 1

nodeAddBtn.states.add
	Home: opacity: 0, scale: 0.8
	Active: opacity: 1, scale: 1.0
	HoverBtn: opacity: 1, scale: 1.2

nodeAddBtnTop.states.add
	Home: opacity: 0, scale: 0.8
	Active: opacity: 1, scale: 1.0
	HoverBtn: opacity: 1, scale: 1.2
		
nodeDetailsEditBtn.states.add
	Home: opacity: 0, scale: 0.8
	Active: opacity: 1, scale: 1.0
	HoverBtn: opacity: 1, scale: 1.2

nodeDeselected.states.add
	Home: scale: 1, opacity: 1
	Hover: scale: 1.1, opacity: 1
	Select: opacity: 0
	
nodeSelected.states.add
	Home: opacity: 0
	Hover: opacity: 0
	Select: opacity: 1
	
nodeControls.states.add
	Home: opacity: 0
	Hover: opacity: 0
	Select: opacity: 1

nodeDetails.states.add
	Home: opacity: 0
	Hover: opacity: 1
	Select: opacity: 1

layers = [nodeDetails, nodeSelected, nodeControls, nodeDeselected]
btns = [nodeAddBtn, nodeAddBtnTop]

# btnLayers = [nodeAddBtnTop, nodeAddBtn]
# for btn in btnLayers
# 	btn.states.add
# 		Hover: opacity: 1, scale: 1.0
# 		HoverA: opacity: 1, scale: 1.1
# 		Home: opacity: 0, scale: 0.8
# 		
# 	btn.on Events.MouseOver, ->
# # 		print('over')
# 		btn.states.switch "HoverA"

# 		
# ---------
# Initiate UI States
# ---------
shadebg.states.switchInstant "Home"
nodeDetailsEditBtn.states.switchInstant "Home"

for btn in btns
	btn.states.switch "Home"
for layer in layers
	#set all states to Home
	layer.states.switchInstant "Home"
	
#initiate draggable states
nodeSelected.draggable.enabled = true
nodeSelected.draggable.vertical = false
nodeSelected.draggable.constraints = 
	width: 400

# ---------
# Events
# ---------

nodeZone.on Events.MouseOver, ->
	if not isSelect
		for btn in btns
			btn.states.switch "Active"
		for layer in layers
			layer.states.switch "Hover"

nodeZone.on Events.MouseOut, ->
	if not isSelect
		for btn in btns
			btn.states.switch "Home"
		for layer in layers
			layer.states.switch "Home"	

nodeSelected.on Events.Click, ->
	if not isSelect
		for btn in btns
			btn.states.switch "Home"

		nodeDeselected.states.switch "Select"
		nodeSelected.states.switch "Select"
		nodeDetails.states.switch "Select", delay: 0.1
		nodeControls.states.switch "Select", delay: 0.1
		nodeDetailsEditBtn.states.switch "Active", delay: .3
		isSelect = true
	else
		for btn in btns
			btn.states.switch "Active"

		nodeDeselected.states.switch "Hover"
		nodeSelected.states.switch "Hover"
		nodeDetails.states.switch "Hover", delay: 0.1
		nodeControls.states.switch "Hover", delay: 0.1
		nodeDetailsEditBtn.states.switch "Home"
		isSelect = false

nodeDetailsEditBtn.on Events.MouseOver, ->
	this.states.switch "HoverBtn"

nodeDetailsEditBtn.on Events.MouseOut, ->
	this.states.switch "Active"
