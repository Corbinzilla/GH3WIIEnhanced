intro_sequence_props = {
	song_title_pos = (5.0, 0.0)
	performed_by_pos = (5.0, 60.0)
	song_artist_pos = (5.0, 75.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = -400
	hud_move_time = 200
}
fastintro_sequence_props = {
	song_title_pos = (5.0, 0.0)
	performed_by_pos = (5.0, 60.0)
	song_artist_pos = (5.0, 75.0)
	song_title_start_time = -6700
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = -400
	hud_move_time = 200
}
practice_sequence_props = {
	song_title_pos = (5.0, 0.0)
	performed_by_pos = (5.0, 60.0)
	song_artist_pos = (5.0, 75.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -3000
	highway_move_time = 2000
	button_ripple_start_time = -1800
	button_ripple_per_button_time = 100
	hud_start_time = -1400
	hud_move_time = 200
}
immediate_sequence_props = {
	song_title_pos = (5.0, 0.0)
	performed_by_pos = (5.0, 60.0)
	song_artist_pos = (5.0, 75.0)
	song_title_start_time = 0
	song_title_fade_time = 700
	song_title_on_time = 0
	highway_start_time = 0
	highway_move_time = 0
	button_ripple_start_time = 0
	button_ripple_per_button_time = 0
	hud_start_time = 0
	hud_move_time = 0
}
current_intro = fast_intro_sequence_props

script play_intro

	
	if (($game_mode = p1_career) || ($game_mode = p1_quickplay))
		CreateScreenElement {
			type = TextElement
			text = 'FC'
			parent = root_window
			id = fc_id
			scale = 1.0
			pos = (275.0, 445.0)
			font = text_a6
			rgba = 	[215 160 110 255]
			alpha = 1
			just = [left bottom]
			z_priority = 99
		}
		CreateScreenElement {
		    Type = SpriteElement
		    Id = fc_glow
		    parent = root_window
		    texture = Char_Select_Hilite1
		    Pos = (270.0, 455.0)
		    rgba = [246 188 102 255]
		    Scale = 1.0
		    Alpha = 1.0
		    z_priority = 1
			just = [left bottom]
	    } 
	endif
	if ($show_boss_helper_screen = 1)
		return
	endif
	if ($is_attract_mode = 1)
		disable_bg_viewport
		return
	endif
	KillSpawnedScript \{name = GuitarEvent_SongFailed_Spawned}
	if GotParam \{Fast}
		change \{current_intro = fastintro_sequence_props}
	elseif GotParam \{practice}
		change \{current_intro = practice_sequence_props}
	else
		change \{current_intro = intro_sequence_props}
	endif
	if ($game_mode != tutorial)
		spawnscriptnow \{intro_song_info
			id = intro_scripts}
	endif
	if NOT ($Cheat_PerformanceMode = 1 && $is_network_game = 0)
		spawnscriptnow \{intro_highway_move
			id = intro_scripts}
	endif
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player>
	FormatText TextName = player_text 'p%i' i = <player>
	spawnscriptnow intro_buttonup_ripple params = <...> id = intro_scripts
	player = (<player> + 1)
	repeat $current_num_players
	spawnscriptnow \{intro_hud_move
		id = intro_scripts}
	wait 2 seconds
endscript

script destroy_intro 
	if ScreenElementExists \{id = fc_id}
		DestroyScreenElement \{id = fc_id}
	endif
	if ScreenElementExists \{id = fc_glow}
		DestroyScreenElement \{id = fc_glow}
	endif
	KillSpawnedScript \{id = intro_scripts}
	KillSpawnedScript \{name = Song_Intro_Kick_SFX_Waiting}
	KillSpawnedScript \{name = Song_Intro_Highway_Up_SFX_Waiting}
	KillSpawnedScript \{name = move_highway_2d}
	KillSpawnedScript \{name = intro_buttonup_ripple}
	KillSpawnedScript \{name = intro_hud_move}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	EnableInput controller = ($<player_status>.controller)
	player = (<player> + 1)
	repeat $current_num_players
endscript

script intro_buttonup_ripple 

	EnableInput off controller = ($<player_status>.controller)
	begin
	GetSongTimeMs
	if ($current_intro.button_ripple_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	if ($current_intro.button_ripple_per_button_time = 0)
		return
	endif
	GetArraySize \{$gem_colors}
	controller = ($<player_status>.controller)
	SoundEvent \{event = Notes_Ripple_Up_SFX}
	ExtendCRC button_up_pixel_array ($<player_status>.text) out = pixel_array
	buttonup_count = 0
	begin
	Wait ($current_intro.button_ripple_per_button_time / 1000.0) seconds
	array_count = 0
	begin
	color = ($gem_colors [<array_count>])
	if (<array_count> = <buttonup_count>)
		SetArrayElement ArrayName = <pixel_array> GlobalArray index = <array_count> newvalue = $button_up_pixels
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	buttonup_count = (<buttonup_count> + 1)
	repeat (<array_size> + 1)
	EnableInput controller = ($<player_status>.controller)
endscript

script intro_song_info 

	begin
	GetSongTimeMs
	if ($current_intro.song_title_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	if ($current_intro.song_title_on_time = 0)
		return
	endif
	get_song_title song = ($current_song)
	GetUpperCaseString <song_title>
	intro_song_info_text :SetProps text = <UpperCaseString>
	GetScreenElementProps \{id = intro_song_info_text}
	GetScreenElementDims \{id = intro_song_info_text}
	x_pos = (<pos>.(1.0, 0.0))
	safe_width = (1280 - 64)
	if ((<x_pos> + <width>) > <safe_width>)
		new_width = (<safe_width> - <x_pos>)
		x_scale = (<new_width> / <width>)
		new_scale = ((<x_scale> * (1.0, 0.0)) + (<scale> * (0.0, 1.0)))
		SetScreenElementProps id = intro_song_info_text scale = <new_scale>
	endif
	intro_song_info_text :DoMorph pos = ($current_intro.song_title_pos)
	get_song_artist song = ($current_song)
	GetUpperCaseString <song_artist>
	intro_artist_info_text :SetProps text = <UpperCaseString>
	intro_artist_info_text :DoMorph pos = ($current_intro.song_artist_pos)
	get_song_artist_text song = ($current_song)
	GetUpperCaseString <song_artist_text>
	intro_performed_by_text :SetProps text = <UpperCaseString>
	intro_performed_by_text :DoMorph pos = ($current_intro.performed_by_pos)
	intro_song_info_text :SetProps \{z_priority = 5.0}
	intro_artist_info_text :SetProps \{z_priority = 5.0}
	intro_performed_by_text :SetProps \{z_priority = 5.0}
	if (($game_mode = p1_career) || ($game_mode = p1_quickplay))
		doScreenElementMorph id = intro_song_info_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
		doScreenElementMorph id = intro_performed_by_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
		doScreenElementMorph id = intro_artist_info_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	endif
endscript

script intro_highway_move 
	begin
	GetSongTimeMs
	if ($current_intro.highway_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	spawnscriptnow \{Song_Intro_Highway_Up_SFX_Waiting}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	FormatText TextName = player_text 'p%i' i = <player> AddToStringLookup
	move_highway_camera_to_default <...> time = ($current_intro.highway_move_time / 1000.0)
	player = (<player> + 1)
	repeat $current_num_players
endscript

script intro_hud_move
	begin
	GetSongTimeMs
	if ($current_intro.hud_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	get_num_players_by_gamemode
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	FormatText TextName = player_text 'p%i' i = <player> AddToStringLookup
	move_hud_to_default <...> time = ($current_intro.hud_move_time / 1000.0)
	player = (<player> + 1)
	repeat <num_players>
	if ($game_mode = p2_battle && $battle_sudden_death = 1)
		restore_saved_powerups
	endif
	spawnscriptnow \{Song_Intro_Kick_SFX_Waiting}
endscript

script practicemode_deinit 
	ClearNoteMappings \{section = practice}
	KillSpawnedScript \{name = practicemode_section}
	if ScreenElementExists \{id = practice_container}
		DestroyScreenElement \{id = practice_container}
	endif
endscript

script play_outro
	if ScreenElementExists \{id = quickplay_container}
		DestroyScreenElement \{id = quickplay_container}
	endif
	if (($game_mode = p1_career) || ($game_mode = p1_quickplay)) 
		doScreenElementMorph id = intro_song_info_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
		doScreenElementMorph id = intro_artist_info_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
		doScreenElementMorph id = intro_performed_by_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	endif
	SongUnLoadFSBIfDownloaded
	Kill_StarPower_Camera \{changecamera = 0}
	Kill_Walk_Camera \{changecamera = 0}
	change \{structurename = player1_status
		star_power_amount = 0}
	change \{structurename = player2_status
		star_power_amount = 0}
	Kill_StarPower_StageFX player_text = ($player1_status.text) player_status = $player1_status ifEmpty = 0
	Kill_StarPower_StageFX player_text = ($player2_status.text) player_status = $player2_status ifEmpty = 0
	change \{showing_raise_axe = 0}
	LaunchGemEvent \{event = kill_objects}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	FormatText TextName = player_text 'p%i' i = <player> AddToStringLookup
	GuitarEvent_KillSong <...>
	destroy_hud <...>
	battlemode_deinit <...>
	bossbattle_deinit <...>
	faceoff_deinit <...>
	faceoff_volumes_deinit <...>
	player = (<player> + 1)
	repeat $max_num_players
	practicemode_deinit
	notemap_deinit
	kill_startup_script <...>
	KillSpawnedScript \{name = create_gem}
	KillSpawnedScript \{name = GuitarEvent_MissedNote}
	KillSpawnedScript \{name = GuitarEvent_UnnecessaryNote}
	KillSpawnedScript \{name = GuitarEvent_HitNotes}
	KillSpawnedScript \{name = GuitarEvent_HitNote}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOn}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOff}
	KillSpawnedScript \{name = GuitarEvent_StarHitNote}
	KillSpawnedScript \{name = GuitarEvent_StarSequenceBonus}
	KillSpawnedScript \{name = GuitarEvent_StarMissNote}
	KillSpawnedScript \{name = GuitarEvent_WhammyOn}
	KillSpawnedScript \{name = GuitarEvent_WhammyOff}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOn}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOff}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Open}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Close}
	KillSpawnedScript \{name = GuitarEvent_crowd_poor_medium}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_good}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_poor}
	KillSpawnedScript \{name = GuitarEvent_crowd_good_medium}
	KillSpawnedScript \{name = GuitarEvent_CreateFirstGem}
	KillSpawnedScript \{name = highway_pulse_black}
	KillSpawnedScript \{name = GuitarEvent_HitNote_Spawned}
	KillSpawnedScript \{name = GuitarEvent_HitNote}
	KillSpawnedScript \{name = Do_StarPower_StageFX}
	KillSpawnedScript \{name = Do_StarPower_Camera}
	KillSpawnedScript \{name = first_gem_fx}
	KillSpawnedScript \{name = gem_iterator}
	KillSpawnedScript \{name = gem_array_stepper}
	KillSpawnedScript \{name = gem_array_events}
	KillSpawnedScript \{name = gem_step}
	KillSpawnedScript \{name = gem_step_end}
	KillSpawnedScript \{name = fretbar_iterator}
	KillSpawnedScript \{name = Strum_iterator}
	KillSpawnedScript \{name = FretPos_iterator}
	KillSpawnedScript \{name = FretFingers_iterator}
	KillSpawnedScript \{name = Drum_iterator}
	KillSpawnedScript \{name = Drum_cymbal_iterator}
	KillSpawnedScript \{name = WatchForStartPlaying_iterator}
	KillSpawnedScript \{name = gem_scroller}
	KillSpawnedScript \{name = button_checker}
	KillSpawnedScript \{name = check_buttons}
	KillSpawnedScript \{name = check_buttons_fast}
	KillSpawnedScript \{name = fretbar_update_tempo}
	KillSpawnedScript \{name = fretbar_update_hammer_on_tolerance}
	KillSpawnedScript \{name = move_whammy}
	KillSpawnedScript \{name = create_fretbar}
	KillSpawnedScript \{name = move_highway_2d}
	KillSpawnedScript \{name = update_score_fast}
	KillSpawnedScript \{name = check_for_star_power}
	KillSpawnedScript \{name = wait_for_inactive}
	KillSpawnedScript \{name = GuitarEvent_PreFretbar}
	KillSpawnedScript \{name = GuitarEvent_Fretbar}
	KillSpawnedScript \{name = check_note_hold}
	KillSpawnedScript \{name = star_power_whammy}
	KillSpawnedScript \{name = show_star_power_ready}
	KillSpawnedScript \{name = hud_glowburst_alert}
	change \{star_power_ready_on_p1 = 0}
	change \{star_power_ready_on_p2 = 0}
	KillSpawnedScript \{name = event_iterator}
	KillSpawnedScript \{name = win_song}
	KillSpawnedScript \{name = hand_note_iterator}
	KillSpawnedScript \{name = kill_object_later}
	KillSpawnedScript \{name = show_coop_raise_axe_for_starpower}
	KillSpawnedScript \{name = net_whammy_pitch_shift}
	KillSpawnedScript \{name = Crowd_AllPlayAnim}
	KillSpawnedScript \{name = hud_activated_star_power_spawned}
	KillSpawnedScript \{name = pulsate_all_star_power_bulbs}
	KillSpawnedScript \{name = pulsate_star_power_bulb}
	KillSpawnedScript \{name = rock_meter_star_power_on}
	KillSpawnedScript \{name = rock_meter_star_power_off}
	KillSpawnedScript \{name = hud_activated_star_power}
	KillSpawnedScript \{name = hud_move_note_scorebar}
	KillSpawnedScript \{name = hud_flash_red_bg_p1}
	KillSpawnedScript \{name = hud_flash_red_bg_p2}
	KillSpawnedScript \{name = hud_flash_red_bg_kill}
	KillSpawnedScript \{name = hud_lightning_alert}
	KillSpawnedScript \{name = hud_show_note_streak_combo}
	KillSpawnedScript \{name = play_intro}
	KillSpawnedScript \{name = begin_song_after_intro}
	if GotParam \{kill_cameracuts_iterator}
		KillSpawnedScript \{name = cameracuts_iterator}
	endif

	KillSpawnedScript \{id = song_event_scripts}

	Destroy_AllWhammyFX
	destroy_intro
	end_song <...>
endscript
