video_settings_menu_font = text_a5
black_highway = 0
auto_activate_Star_power = 0
disable_hit_note_fx = 0
disable_fc = 0
no_miss = 0
script create_modmenu \{popup = 0}
	kill_start_key_binding
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = vom_container
		pos = (0.0, 0.0)}
	if (<popup> = 0)
		new_menu \{scrollid = vs_scroll
			vmenuid = vs_vmenu
			font = $video_settings_menu_font
			menu_pos = (0.0, 0.0)
			spacing = 40
			text_left}
	change \{menu_focus_color = [0 255 255 255]}
	change \{menu_unfocus_color = [0 255 199 255]}
		displayText \{parent = vom_container
			pos = (0.0, 0.0)
			just = [
				right
				bottom
			]
			text = 'Mod Settings'
			scale = 1.5
			rgba = [
				240
				235
				240
				255
			]
			font = $video_settings_menu_font
			noshadow}
		GetScreenElementDims id = <id>
		if (<width> > 375)
			SetScreenElementProps id = <id> scale = 1
			fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <Height> * (0.0, 1.0))
		endif
		create_menu_backdrop \{texture = Venue_BG}

		GetGlobalTags \{user_options}
		displaySprite \{parent = vom_container
			id = vom_hilite
			tex = white
			pos = (0.0, 415.0)
			rgba = [
				40
				60
				110
				255
			]
			dims = (280.0, 40.0)
			z = 2}
		add_user_control_helper \{text = 'SELECT'
			button = green
			z = 100}
		add_user_control_helper \{text = 'BACK'
			button = red
			z = 100}
		add_user_control_helper \{text = 'UP/DOWN'
			button = strumbar
			z = 100}
		text_params = {
			parent = vs_vmenu
			type = TextElement
			font = $video_settings_menu_font
			rgba = ($menu_unfocus_color)
			scale = 0.85
			z_priority = 3
		}
		<exclusive_params> = {exclusive_device = ($primary_controller)}
	else
		z = 100
		new_menu scrollid = vs_scroll vmenuid = vs_vmenu menu_pos = (0.0, 340.0) exclusive_device = ($last_start_pressed_device)
		SetScreenElementProps \{id = vs_vmenu
			dims = (1280.0, 720.0)
			internal_just = [
				center
				top
			]}
		create_pause_menu_frame z = (<z> - 10)
		calibrate_text = 'CALIBRATE LAG'
		text_params = {parent = vs_vmenu type = TextElement font = ($audio_settings_menu_font) rgba = ($menu_unfocus_color) scale = 1 z_priority = <z>}
		<exclusive_params> = {exclusive_device = ($last_start_pressed_device)}
		CreateScreenElement {
			type = SpriteElement
			parent = vom_container
			texture = menu_pause_frame_banner
			pos = (640.0, 540.0)
			just = [center center]
			z_priority = (<z> + 100)
		}
		CreateScreenElement {
			type = TextElement
			parent = <id>
			text = 'PAUSED'
			font = text_a6
			pos = (125.0, 53.0)
			rgba = [170 90 30 255]
			scale = 0.8
		}
	endif

	CreateScreenElement {
		type = TextElement
		id = toggle_light_show_text
		text = 'Light Show: ON'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		pos = (0.0, 0.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose togglelightshow}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 0.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))


	CreateScreenElement {
		type = TextElement
		id = toggle_black_highway_text
		text = 'Black Highway: OFF'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		pos = (0.0, 40.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose toggleblackhighway}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 40.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))

	CreateScreenElement {
		type = TextElement
		id = toggle_auto_activating_star_power
		text = 'Auto Activating Star Power: OFF'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		pos = (0.0, 80.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose toggleautoactivatingstarpower}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 80.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))

	CreateScreenElement {
		type = TextElement
		id = toggle_hit_note_fx_text
		text = 'Disable Hit Note FX: OFF'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		pos = (0.0, 120.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose togglehitnotefx}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 120.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))

	CreateScreenElement {
		type = TextElement
		id = toggle_ds_lookin_highway_text
		text = 'DS Lookin Highway: OFF'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		pos = (0.0, 160.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose toggledshighway}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 160.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))

	CreateScreenElement {
		type = TextElement
		id = toggle_no_miss_text
		text = 'No Miss: OFF'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		pos = (0.0, 200.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose togglenomiss}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 200.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))

	CreateScreenElement {
		type = TextElement
		id = disable_fc_text
		text = 'Disable FC Text: OFF'
		scale = 1
		rgba = [255 255 255 255]
		parent = vs_vmenu
		font = text_a5
		pos = (0.0, 240.0)
		event_handlers = [
			{focus vom_focus params = {item = calibrate popup = <popup>}}
			{unfocus vom_unfocus params = {item = calibrate popup = <popup>}}
			{pad_choose togglefctext}
		]
	}
	<id> :SetTags hilite_pos = (0.0, 240.0)
	GetScreenElementDims id = <id>
	<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))











	if ($lightshow_enabled = 0)
		SetScreenElementProps \{id = toggle_light_show_text text = 'Light Show: OFF'}
	else
		SetScreenElementProps \{id = toggle_light_show_text text = 'Light Show: ON'}
	endif
	if (black_highway = 0)
		SetScreenElementProps \{id = toggle_black_highway_text text = 'Black Highway: OFF'}
	else
		SetScreenElementProps \{id = toggle_black_highway_text text = 'Black Highway: ON'}
	endif
	if ($auto_activate_Star_power = 0)
		SetScreenElementProps \{id = toggle_auto_activating_star_power text = 'Auto Activating Star Power: OFF'}
	else
		SetScreenElementProps \{id = toggle_auto_activating_star_power text = 'Auto Activating Star Power: ON'}
	endif	
	if (disable_hit_note_fx = 1)
		SetScreenElementProps \{id = toggle_hit_note_fx_text text = 'Disable Hit Note FX: ON'}
	else
		SetScreenElementProps \{id = toggle_hit_note_fx_text text = 'Disable Hit Note FX: OFF'}
	endif	
	if ($highway_height1 = 350)
		SetScreenElementProps \{id = toggle_ds_lookin_highway_text text = 'DS Lookin Highway: OFF'}
	else
		SetScreenElementProps \{id = toggle_ds_lookin_highway_text text = 'DS Lookin Highway: ON'}
	endif
	if (no_miss = 1)
		SetScreenElementProps \{id = toggle_no_miss_text text = 'No Miss: ON'}
	else
		SetScreenElementProps \{id = toggle_no_miss_text text = 'No Miss: OFF'}
	endif
	if (disable_fc = 0)
		SetScreenElementProps \{id = disable_fc_text text = 'Disable FC Text: OFF'}
	else
		SetScreenElementProps \{id = disable_fc_text text = 'Disable FC Text: ON'}
	endif


	if isps2
		get_string_ps2 \{message = widescreen_string}
		CreateScreenElement {
			<text_params>
			text = <localized_string>
			event_handlers = [
				{focus vom_focus params = {item = wide_scrn popup = <popup>}}
				{unfocus vom_unfocus params = {item = wide_scrn popup = <popup>}}
				{pad_choose menu_video_settings_select_widescreen}
			]
		}
		<id> :SetTags hilite_pos = (285.0, 448.0)
		GetScreenElementDims id = <id>
		<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))
		if (<ps2_widescreen> = 1)
			displaySprite \{parent = vom_container
				id = widescrn_check
				tex = options_video_on
				pos = (300.0, 450.0)
				dims = (32.0, 32.0)
				z = 6}
		else
			displaySprite \{parent = vom_container
				id = widescrn_check
				tex = options_video_off
				pos = (300.0, 450.0)
				dims = (32.0, 32.0)
				z = 6}
		endif
		if NOT IsPAL
			get_string_ps2 \{message = progressivescan_string}
			CreateScreenElement {
				<text_params>
				text = <localized_string>
				event_handlers = [
					{focus vom_focus params = {item = prg_scan popup = <popup>}}
					{unfocus vom_unfocus params = {item = prg_scan popup = <popup>}}
					{pad_choose menu_video_settings_select_progressive_scan}
				]
			}
			<id> :SetTags hilite_pos = (285.0, 489.0)
			GetScreenElementDims id = <id>
			<id> :SetTags hilite_dims = (<width> * (1.1, 0.0) + (55.0, 40.0))
			if ($PS2_ProgressiveScan = 1)
				displaySprite \{parent = vom_container
					id = prgscn_check
					tex = options_video_on
					pos = (300.0, 490.0)
					dims = (32.0, 32.0)
					z = 6}
			else
				displaySprite \{parent = vom_container
					id = prgscn_check
					tex = options_video_off
					pos = (300.0, 490.0)
					dims = (32.0, 32.0)
					z = 6}
			endif
		endif
	endif
endscript

script togglelightshow
	playsound \{cash}
	if ($lightshow_enabled = 1)
		change \{lightshow_enabled = 0}
		SetScreenElementProps \{id = toggle_light_show_text text = 'Light Show: OFF'}
	else
		change \{lightshow_enabled = 1}
		SetScreenElementProps \{id = toggle_light_show_text text = 'Light Show: ON'}
	endif
endscript

script toggleblackhighway
	playsound \{cash}
	if (black_highway = 1)
		change \{black_highway = 0}
		change \{highway_normal = [255 255 255 255]}
		change \{highway_starpower = [64 160 160 255]}
		SetScreenElementProps \{id = toggle_black_highway_text text = 'Black Highway: OFF'}
	else
		change \{black_highway = 1}
		change \{highway_normal = [0 0 0 255]}
		change \{highway_starpower = [30 30 30 255]}
		SetScreenElementProps \{id = toggle_black_highway_text text = 'Black Highway: ON'}
	endif

endscript

script toggleautoactivatingstarpower
	playsound \{cash}
	if ($auto_activate_Star_power = 0)
		change \{auto_activate_Star_power = 1}
		SetScreenElementProps \{id = toggle_auto_activating_star_power text = 'Auto Activating Star Power: ON'}
	else
		change \{auto_activate_Star_power = 0}
		SetScreenElementProps \{id = toggle_auto_activating_star_power text = 'Auto Activating Star Power: OFF'}
	endif
endscript

script togglehitnotefx
	playsound \{cash}
	if (disable_hit_note_fx = 1)
		change \{disable_hit_note_fx = 0}
		SetScreenElementProps \{id = toggle_hit_note_fx_text text = 'Disable Hit Note FX: OFF'}
	else
		change \{disable_hit_note_fx = 1}
		SetScreenElementProps \{id = toggle_hit_note_fx_text text = 'Disable Hit Note FX: ON'}
	endif
endscript


script toggledshighway
	playsound \{cash}
	if ($highway_height1 = 350)
		change \{highway_height1 = 600}
		SetScreenElementProps \{id = toggle_ds_lookin_highway_text text = 'DS Lookin Highway: ON'}
	else
		change \{highway_height1 = 350}
		SetScreenElementProps \{id = toggle_ds_lookin_highway_text text = 'DS Lookin Highway: OFF'}
	endif
	if ($highway_height2 = 270)
		change \{highway_height2 = 500}
		SetScreenElementProps \{id = toggle_ds_lookin_highway_text text = 'DS Lookin Highway: ON'}
	else
		change \{highway_height2 = 270}
		SetScreenElementProps \{id = toggle_ds_lookin_highway_text text = 'DS Lookin Highway: OFF'}
	endif
endscript

script togglenomiss
	playsound \{cash}
	if (no_miss = 1)
		change \{no_miss = 0}
		SetScreenElementProps \{id = toggle_no_miss_text text = 'No Miss: OFF'}
	else
		change \{no_miss = 1}
		SetScreenElementProps \{id = toggle_no_miss_text text = 'No Miss: ON'}
	endif
endscript

script togglefctext
	if (disable_fc = 0)
		change \{disable_fc = 1}
		SetScreenElementProps \{id = disable_fc_text text = 'Disable FC Text: ON'}
	else
		change \{disable_fc = 0}
		SetScreenElementProps \{id = disable_fc_text text = 'Disable FC Text: OFF'}
	endif
endscript







script destroy_modmenu
	restore_start_key_binding
	clean_up_user_control_helpers
	destroy_menu_backdrop
	destroy_menu \{menu_id = vom_container}
	destroy_menu \{menu_id = vs_scroll}
	destroy_pause_menu_frame
endscript

script vom_focus 
	retail_menu_focus
	if (<popup> = 0)
		GetTags
		<id> :GetTags
		if ScreenElementExists \{id = vom_hilite}
			vom_hilite :SetProps pos = <hilite_pos>
			vom_hilite :SetProps dims = <hilite_dims>
		endif
	endif
endscript

script vom_unfocus 
	retail_menu_unfocus
	if (<popup>)
		return
	endif
endscript




script menu_video_settings_select_progressive_scan 
	if ($PS2_ProgressiveScan = 1)
		SetScreenElementProps \{id = prgscn_check
			texture = options_video_off
			dims = (32.0, 32.0)}
		change \{PS2_ProgressiveScan = 0}
		SetProgressive \{on = 0}
	else
		current_flow_state_name = ($ui_flow_manager_state [0])
		change ps2_saveload_successor = <current_flow_state_name>
		HACK_ps2_set_saveload_successor_checksum <current_flow_state_name>
		change \{ps2_saveload_successor_action_state = {
				please_dont_crash
			}}
		previous_flow_state_name = ($previous_flow_manager_state [0])
		ui_flow_HACK_previous_state = <previous_flow_state_name>
		ui_flow_manager_respond_to_action \{action = select_progressive_scan}
	endif
endscript

script menu_video_settings_select_widescreen 
	GetGlobalTags \{user_options}
	if (<ps2_widescreen> = 1)
		SetScreenElementProps \{id = widescrn_check
			texture = options_video_off
			dims = (32.0, 32.0)}
		SetGlobalTags \{user_options
			params = {
				ps2_widescreen = 0
			}}
		SetScreen \{widescreen = 0}
	else
		SetScreenElementProps \{id = widescrn_check
			texture = options_video_on}
		SetScreenElementProps \{id = widescrn_check
			texture = options_video_on
			dims = (32.0, 32.0)}
		SetGlobalTags \{user_options
			params = {
				ps2_widescreen = 1
			}}
		SetScreen \{widescreen = 1}
	endif
endscript
ps2_waiting_on_progressive_scan = 0

script ps2_cancel_progressive_scan 
	change \{ps2_waiting_on_progressive_scan = 0}
	change \{PS2_ProgressiveScan = 0}
	SetProgressive \{on = 0}
	ui_flow_manager_respond_to_action \{action = leave_warning_flow}
endscript

script ps2_try_progressive_scan 
	change \{ps2_waiting_on_progressive_scan = 1}
	change \{PS2_ProgressiveScan = 1}
	SetProgressive \{on = 1}
	refresh_ps2_trc_menu <...>
	spawnscriptnow \{ps2_progressive_scan_timer}
endscript

script ps2_progressive_scan_timer 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	ps2_prog_timer = 0
	begin
	WaitOneGameFrame
	if NOT ($ps2_waiting_on_progressive_scan = 1)
		return
	endif
	if (<ps2_prog_timer> > (60 * 15))
		ps2_cancel_progressive_scan
		return
	endif
	ps2_prog_timer = (<ps2_prog_timer> + 1)
	repeat
endscript

script ps2_accept_progressive_scan 
	KillSpawnedScript \{name = ps2_progressive_scan_timer}
	change \{ps2_waiting_on_progressive_scan = 0}
	ui_flow_manager_respond_to_action \{action = leave_warning_flow}
endscript
