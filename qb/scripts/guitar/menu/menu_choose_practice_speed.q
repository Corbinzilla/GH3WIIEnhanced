menu_choose_practice_destroy_previous_menu = 1
menu_choose_practice_speed_font = text_a3
menu_choose_practice_speed_is_exiting = 0

script create_choose_practice_speed_menu 
	change \{menu_choose_practice_speed_is_exiting = 0}
	disable_pause
	if ScreenElementExists \{id = cps_menu}
		LaunchEvent \{type = unfocus
			target = cps_menu}
	endif
	if ScreenElementExists \{id = newspaper_vmenu}
		LaunchEvent \{type = unfocus
			target = newspaper_vmenu}
	endif
	event_handlers = [
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
		{pad_back practice_speed_go_back}
	]
	new_menu scrollid = cps_scroll vmenuid = cps_vmenu menu_pos = (640.0, 260.0) spacing = -60 event_handlers = <event_handlers>
	change \{menu_focus_color = [0 255 255 255]}
	change \{menu_unfocus_color = [0 255 199 255]}
	text_params = {
		parent = cps_vmenu
		type = TextElement
		font = ($menu_choose_practice_speed_font)
		rgba = ($menu_unfocus_color)
		z_priority = 700
		scale = 1.1
		just = [center center]
	}
	menu_z = 500
	CreateScreenElement \{type = ContainerElement
		id = cps_speed_container
		parent = root_window
		pos = (0.0, 0.0)}
	displaySprite \{parent = cps_speed_container
		pos = (640.0, 360.0)
		just = [
			right
			bottom
		]
		tex = practice_speed_bg
		dims = (320.0, 320.0)
		z = 600
		flip_v}
	displaySprite \{parent = cps_speed_container
		pos = (640.0, 360.0)
		just = [
			left
			bottom
		]
		tex = practice_speed_bg
		dims = (320.0, 320.0)
		z = 600}
	displaySprite \{parent = cps_speed_container
		pos = (640.0, 360.0)
		just = [
			left
			top
		]
		tex = practice_speed_bg
		dims = (320.0, 320.0)
		z = 600
		flip_h}
	CreateScreenElement \{type = SpriteElement
		parent = cps_speed_container
		pos = (640.0, 360.0)
		just = [
			right
			top
		]
		texture = practice_speed_bg
		dims = (320.0, 320.0)
		z_priority = 600
		flip_v
		flip_h}
	displaySprite \{parent = cps_speed_container
		id = cps_hilite
		tex = white
		z = 550
		rgba = [
			215
			120
			40
			255
		]
		just = [
			center
			center
		]
		z = 699}
	displaySprite \{parent = cps_speed_container
		id = cps_hilite_be1
		tex = character_hub_hilite_bookend
		z = 550
		rgba = [
			215
			120
			40
			255
		]
		just = [
			right
			center
		]
		z = 699}
	displaySprite \{parent = cps_speed_container
		id = cps_hilite_be2
		tex = character_hub_hilite_bookend
		z = 550
		rgba = [
			215
			120
			40
			255
		]
		just = [
			left
			center
		]
		z = 699}
	CreateScreenElement \{type = SpriteElement
		parent = cps_speed_container
		texture = gradient_128
		rgba = [
			0
			0
			0
			180
		]
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 500}
	CreateScreenElement \{type = TextElement
		parent = cps_speed_container
		text = 'Select Speed'
		font = text_a10
		rgba = [
			215
			120
			40
			255
		]
		scale = 1.5
		pos = (640.0, 240.0)
		just = [
			center
			center
		]
		z_priority = 700}
	CreateScreenElement {
		<text_params>
		type = ContainerElement
		dims = (0.0, 100.0)
		event_handlers = [
			{focus practice_choose_speed_hilite params = {id = ps_fullspeed pos = (640.0, 317.0)}}
			{unfocus retail_menu_unfocus params = {id = ps_fullspeed}}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = full}}
		]
	}
	CreateScreenElement {
		<text_params>
		parent = <id>
		id = ps_fullspeed
		text = 'Full Speed'
	}
	CreateScreenElement {
		<text_params>
		type = ContainerElement
		dims = (0.0, 100.0)
		event_handlers = [
			{focus practice_choose_speed_hilite params = {id = ps_fast pos = (640.0, 369.0)}}
			{unfocus retail_menu_unfocus params = {id = ps_fast}}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = fast}}
		]
	}
	CreateScreenElement {
		<text_params>
		parent = <id>
		id = ps_fast
		text = 'Fast'
	}
	CreateScreenElement {
		<text_params>
		type = ContainerElement
		dims = (0.0, 100.0)
		event_handlers = [
			{focus practice_choose_speed_hilite params = {id = ps_faster pos = (640.0, 420.0)}}
			{unfocus retail_menu_unfocus params = {id = ps_faster}}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = faster}}
		]
	}
	CreateScreenElement {
		<text_params>
		parent = <id>
		id = ps_faster
		text = 'Faster'
	}
	CreateScreenElement {
		<text_params>
		type = ContainerElement
		dims = (0.0, 100.0)
		event_handlers = [
			{focus practice_choose_speed_hilite params = {id = ps_alilfaster pos = (640.0, 469.0)}}
			{unfocus retail_menu_unfocus params = {id = ps_alilfaster}}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = alilfaster}}
		]
	}
	CreateScreenElement {
		<text_params>
		parent = <id>
		id = ps_alilfaster
		text = 'ALilFaster'
	}
	CreateScreenElement {
		<text_params>
		type = ContainerElement
		dims = (0.0, 100.0)
		event_handlers = [
			{focus practice_choose_speed_hilite params = {id = ps_fastest pos = (640.0, 518.0)}}
			{unfocus retail_menu_unfocus params = {id = ps_fastest}}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = fastest}}
		]
	}
	CreateScreenElement {
		<text_params>
		parent = <id>
		id = ps_fastest
		text = 'Fastest'
	}
	CreateScreenElement {
		<text_params>
		type = ContainerElement
		dims = (0.0, 100.0)
		event_handlers = [
			{focus practice_choose_speed_hilite params = {id = ps_waitno pos = (640.0, 567.0)}}
			{unfocus retail_menu_unfocus params = {id = ps_waitno}}
			{pad_choose menu_choose_practice_speed_set_speed params = {Speed = waitno}}
		]
	}
	CreateScreenElement {
		<text_params>
		parent = <id>
		id = ps_waitno
		text = 'Wait, NO!'
	}
	change \{menu_choose_practice_destroy_previous_menu = 0}
endscript

script destroy_choose_practice_speed_menu 
	if ($shutdown_game_for_signin_change_flag = 1)
		change \{menu_choose_practice_destroy_previous_menu = 1}
	endif
	destroy_choose_practice_section_menu
	destroy_newspaper_menu
	destroy_menu \{menu_id = cps_speed_container}
	destroy_menu \{menu_id = cps_scroll}
endscript

script practice_speed_go_back 
	if ($menu_choose_practice_speed_is_exiting = 0)
		change \{menu_choose_practice_speed_is_exiting = 1}
		WaitOneGameFrame
		change \{menu_choose_practice_destroy_previous_menu = 0}
		menu_flow_go_back
	endif
endscript

script practice_choose_speed_hilite 
	GetScreenElementDims id = <id>
	new_dims = (<width> * (1.5, 0.0) + (0.0, 45.0))
	SetScreenElementProps id = cps_hilite pos = <pos> dims = <new_dims>
	SetScreenElementProps id = cps_hilite_be1 pos = (<pos> - (<new_dims>.(0.5, 0.0) * (1.0, 0.0)) + (12.0, 0.0))
	SetScreenElementProps id = cps_hilite_be2 pos = (<pos> + (<new_dims>.(0.5, 0.0) * (1.0, 0.0)) - (4.0, 0.0))
endscript

script menu_choose_practice_speed_set_speed \{Speed = full}
	if ($menu_choose_practice_speed_is_exiting = 0)
		change \{menu_choose_practice_speed_is_exiting = 1}
		WaitOneGameFrame
		switch <Speed>
			case full
			change \{current_speedfactor = 1.0}
			change \{structurename = PitchShiftSlow1
				pitch = 1.0}
			if (IsNgc)
				change \{structurename = PitchShiftSlowWii1
					pitch = 1.0}
			endif
			case fast
			change \{current_speedfactor = 1.25}
			change \{structurename = PitchShiftSlow1
				pitch = 0.8}
			if (IsNgc)
				change \{structurename = PitchShiftSlowWii1
					pitch = 0.8}
			endif
			case faster
			change \{current_speedfactor = 1.50}
			change \{structurename = PitchShiftSlow1
				pitch = 0.67}
			if (IsNgc)
				change \{structurename = PitchShiftSlowWii1
					pitch = 0.67}
			endif
			case alilfaster
			change \{current_speedfactor = 1.75}
			change \{structurename = PitchShiftSlow1
				pitch = 0.59}
			if (IsNgc)
				change \{structurename = PitchShiftSlowWii1
					pitch = 0.59}
			endif
			case fastest
			change \{current_speedfactor = 2.0}
			change \{structurename = PitchShiftSlow1
				pitch = 0.5}
			if (IsNgc)
				change \{structurename = PitchShiftSlowWii1
					pitch = 0.5}
			endif
			case waitno
			change \{current_speedfactor = 3.0}
			change \{structurename = PitchShiftSlow1
				pitch = 0.33}
			if (IsNgc)
				change \{structurename = PitchShiftSlowWii1
					pitch = 0.33}
			endif

		endswitch
		change \{menu_choose_practice_destroy_previous_menu = 1}
		ui_flow_manager_respond_to_action action = continue device_num = (<device_num>)
	endif
endscript
