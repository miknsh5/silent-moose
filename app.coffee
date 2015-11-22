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

# states
shadebg.states.add
	Home: opacity: 0
	Hover: opacity: 0.8
	Select: opacity: 1

nodeAddBtn.states.add
	Home: opacity: 0
	Hover: opacity: 1
	Select: opacity: 0

nodeAddBtnTop.states.add
	Home: opacity: 0
	Hover: opacity: 1
	Select: opacity: 0
	
nodeDeselected.states.add
	Home: scale: 1
	Hover: scale: 1.1
	Select: scale: 1
	
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

layers = [nodeDetails, nodeSelected, nodeControls, nodeDeselected, nodeAddBtnTop, nodeAddBtn]

# Initiate UI States
shadebg.states.switchInstant "Home"
for layer in layers
	#set all states to Home
	layer.states.switchInstant "Home"
	
#initiate draggable states
nodeSelected.draggable.enabled = true
nodeSelected.draggable.vertical = false
nodeSelected.draggable.constraints = 
	width: 400

nodeSelected.on Events.MouseOver, ->
	if not isSelect
		for layer in layers
			layer.states.switch "Hover"
			
# 		nodeAddBtn.states.switch "Hover"
# 		nodeAddBtnTop.states.switch "Hover"
# 		nodeSelected.states.switch "Hover"
# 		nodeDeselected.states.switch "Hover"
# 		nodeDetails.states.switch "Hover", delay: 0.1
# 		nodeControls.states.switch "Hover", delay: 0.2

nodeSelected.on Events.MouseOut, ->
# 	print(isSelect)
	if not isSelect
		nodeAddBtn.states.switch "Home"
		nodeSelected.states.switch "Home"
		nodeDeselected.states.switch "Home"
		nodeDetails.states.switch "Home", delay: 0.1
		nodeControls.states.switch "Home", delay: 0.1

nodeSelected.on Events.Click, ->
	if not isSelect
		nodeSelected.states.switch "Select"
		nodeDetails.states.switch "Select", delay: 0.1
		nodeControls.states.switch "Select", delay: 0.1
		isSelect = true
	else
		nodeSelected.states.switch "Hover"
		nodeDetails.states.switch "Hover", delay: 0.1
		nodeControls.states.switch "Hover", delay: 0.1
		isSelect = false
