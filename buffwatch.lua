shihei = 0 
utsubuff = "\\cs(255,0,0)0"
phalanxyn = "\\cs(255,127,0)No"
reprisalyn = "\\cs(255,127,0)No"
cocoonyn = "\\cs(255,127,0)No" 
function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Sakpata','SakpataMDT','Acc')
    state.HybridMode:options('Normal','Tank','DDTank')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT','PDT_HP','PDT_Reraise')
    state.MagicalDefenseMode:options('MDT_HP','MDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA','MEVA_HP')
	state.IdleMode:options('Normal','Tank','Magic','PDT','MDT','Kiting')
	state.Weapons:options('None','BurtgangOchain','BurtgangAegis','NaeglingOchain','NaeglingAegis','Cleave')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode PDT')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {main="Burtgang",sub="Ochain",ammo="Paeapua",
        head="Loess Barbuta +1",neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Cryptic Earring",
        body="Souv. Cuirass +1",hands="Souveran handschuhs +1",ring1="Apeile Ring +1",ring2="Eihwaz Ring",
        back=gear.PLDEnm,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Eschite Greaves"}
		
    sets.Enmity.SIRD = {main="Burtgang",
    	sub="Sacro Bulwark",
    	ammo="Staunch Tathlum +1", --11
		head="Souveran Schaller +1", --20
		neck="Moonbeam Necklace", -- 10
		ear1="Nourishing earring +1", --1
		ear2="Knightly Earring", -- 9
		body="Souv. Cuirass +1",
		hands="Souveran handschuhs +1",
		ring1="Apeile Ring +1",
		ring2="Defending Ring",
		back=gear.PLDFC,
		waist="Rumination Sash", --10
		legs="Carmine Cuisses +1", --20
		feet=gear.odyssean_SIRDFeet -- 20
	}
		
    sets.Enmity.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Eihwaz Ring",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{head="Caballarius Coronet +1"}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat +1", "Reverence Coronet +1"}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +1"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{head="Caballarius Coronet +1"}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {body="Cab. Surcoat +1","Reverence Coronet +1"}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Defending Ring",ring2="Rufescent Ring",
		back=gear.PLDEnm,waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}
		
    sets.precast.JA['Chivalry'].DT = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Eihwaz Ring",ring2="Defending Ring",
		back="Moonbeam Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1", ear2="Knightly Earring"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +1", ear2="Knightly Earring"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Rev. Surcoat +3",hands="Regal Gauntlets",ring1="Asklepian Ring",ring2="Valseur's Ring",
		back="Moonbeam Cape",waist="Chaac Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Aurgelmir Orb +1",
        head="Carmine Mask +1",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Flamma Korazin +2",hands="Regal Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {main="Sakpata's Sword",ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Baetyl Pendant",ear2="Tuisto Earring",ear1="Etiolation Earring",
		body="Rev. Surcoat +3",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Moonbeam Ring",
		back=gear.PLDFC,waist="Creed Baudrier",legs=gear.odyssean_MagFCLegs,feet="Carmine greaves +1"}
		
    sets.precast.FC.DT = {main="Burtgang",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
        back=gear.PLDFC,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", ear1="Mimir Earring"})
	sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {waist="Siegel Sash", ear1="Mimir Earring"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",body="Jumalik Mail"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Amar Cluster",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Regal Ring",ring2="Epaminondas's ring",
        back=gear.PLDWS,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame sollerets"}
		
    sets.precast.WS.DT = {ammo="Amar Cluster",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Regal Ring",ring2="Epaminondas's ring",
        back=gear.PLDWS,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame sollerets"}

    sets.precast.WS.Acc = {ammo="Amar Cluster",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Regal Ring",ring2="Epaminondas's ring",
        back=gear.PLDWS,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Amar Cluster",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nyame Mail",hands="Nyame gauntlets",ring1="Rufescent Ring",ring2="Epaminondas's ring",
        back=gear.PLDWS,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame sollerets"})

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Mache Earring +1",ear2="Telos Earring", waist="Sailfi Belt +1"})
	
	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS)

    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum", head="Pixie Hairpin +1", body="Nyame Mail",
            hands="Carmine Fin. Ga. +1",legs="Nyame Flanchard",feet="Nyame Sollerets",
            neck="Sanctity Necklace", waist="Orpheus's Sash", ear1="Friomisi Earring", ear2="Novio Earring",
            ring1="Archon Ring", ring2="Metamor. Ring +1",
            back=gear.PLDWS}

     sets.precast.WS['Aeolian Edge'] = {ammo="Ghastly Tathlum +1",
        head="Nyame Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Metamor. Ring +1",
        back=gear.PLDWS,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.precast.WS['Atonement'] = {ammo="Paeapua",
        head="Loess Barbuta +1",neck="Moonlight Necklace",ear1="Friomisi Earring",ear2="Cryptic Earring",
        body="Souv. Cuirass +1",hands="Souveran handschuhs +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back=gear.PLDEnm,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Eschite Greaves"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {main="Sakpata's Sword",ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Rev. Surcoat +3",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
		back=gear.PLDFC,waist="Tempus Fugit +1",legs=gear.odyssean_MagFCLegs,feet="Carmine greaves +1"}

	sets.midcast.FastRecast.DT = {main="Sakpata's Sword",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Defending",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",neck="Sacro Gorget",ear1="Mendicant's earring",ear2="Nourish. Earring +1",
		body="Souveran Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.PLDFC,waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
    sets.midcast.Cure.SIRD = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Knightly Earring",ear2="Nourish. Earring +1",
		body="Souveran Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.PLDFC,waist="Rumination sash",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
    sets.midcast.Cure.DT = {main="Deacon Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
    sets.midcast.Reprisal = {main="Sakpata's Sword",ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Eihwaz Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souveran Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Self_Healing = {main="Deacon Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Sacro Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	sets.Self_Healing.SIRD = {main="Deacon Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Founder's Hose",feet="Odyssean Greaves"}
		
	sets.Self_Healing.DT = {main="Deacon Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {main="Colada",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
		body="Shab. Cuirass +1",hands="Regal Gauntlets",ring1="Defending Ring",ring2="Kishar Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1",feet=gear.odyssean_SIRDFeet}
		
    sets.midcast['Enhancing Magic'].SIRD = {main="Colada",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Incanter's Torque",ear1="Mimir Earring",ear2="Tuisto Earring",
		body="Shab. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Rev. Leggings +3",feet=gear.odyssean_SIRDFeet}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {main="Sakpata's Sword",body=gear.odyssean_PhalanxBody,
	 hands="Souv. Handsch. +1",back="Weard Mantle",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1",ear1="Mimir Earring"})

	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {main="Sakpata's Sword",sub="Ochain",body=gear.odyssean_PhalanxBody,
	hands="Souv. Handsch. +1",neck="Moonbeam Necklace",back="Weard Mantle",waist="Rumination Sash",feet="Souveran Schuhs +1"})

	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})

	sets.Phalanx_Received = {main="Sakpata's Sword",hands="Souv. Handsch. +1",body=gear.odyssean_PhalanxBody,
		back="Weard Mantle",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1",}
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Moonbeam Cape",waist="Fucho-no-obi",legs="Sulev. Cuisses +2",feet="Cab. Leggings +1"}

    -- Idle sets
    sets.idle = {main="Burtgang",sub="Ochain",ammo="Eluder's sachet",
        head="Sakpata's Helm",neck="Loricate Torque +1",ear1="Odnowa earring +1",ear2="Tuisto earring",
        body="Sakpata's breastplate",hands="Sakpata's gauntlets",ring1="Fortified Ring",ring2="Defending Ring",
        back=gear.PLDEnm,waist="Carrier's sash",legs="Carmine Cuisses +1",feet="Sakpata's Leggings"}
		
    sets.idle.PDT = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Loricate Torque +1",ear1="Odnowa earring +1",ear2="Tuisto earring",
        body="Sakpata's breastplate",hands="Sakpata's gauntlets",ring1="Gelatinous ring +1",ring2="Defending Ring",
        back=gear.PLDEnm,waist="Carrier's sash",legs="Carmine Cuisses +1",feet="Sakpata's Leggings"}

    sets.idle.Magic = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa earring +1",ear2="Tuisto earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Defending Ring",
		back=gear.PLDEnm,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.idle.Block = {main="Deacon Sword",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Chevalier's Armet +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Thureous Earring",
		body="Sakpata's Breastplate",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1"}
		
    sets.idle.MDT = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa earring +1",ear2="Tuisto earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Defending Ring",
		back="Moonbeam Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.Tank = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Loricate Torque +1",ear1="Odnowa earring +1",ear2="Tuisto earring",
        body="Sakpata's breastplate",hands="Sakpata's gauntlets",ring1="Gelatinous ring +1",ring2="Defending Ring",
        back=gear.PLDEnm,waist="Carrier's sash",legs="Carmine Cuisses +1",feet="Sakpata's Leggings"}
		
	sets.idle.Kiting = {main="Burtgang",sub="Ochain",ammo="Eluder's sachet",
		head="Sakpata's Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Fortified Ring",ring2="Warden's Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Sakpata's Leggings"}

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {main="Malignance Sword",waist="Fucho-no-obi",head="Jumalik Helm"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
	sets.passive.AbsorbMP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.BurtgangOchain = {main="Burtgang",sub="Ochain"}
	sets.weapons.BurtgangAegis = {main="Burtgang",sub="Aegis"}
	sets.weapons.SakpataAegis = {main="Sakpata's Sword",sub="Aegis"}
	sets.weapons.NaeglingOchain = {main="Naegling",sub="Ochain"}
	sets.weapons.NaeglingAegis = {main="Naegling",sub="Aegis"}
	sets.weapons.SakpataOchain = {main="Sakpata's Sword",sub="Ochain"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Machaera +2"}
    sets.weapons.Cleave = {main="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',},sub="Ochain"}

    sets.defense.Block = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Chev. Armet +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Thureous Earring",
		body="Sakpata's Breastplate",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Warden's Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1"}
		
	sets.defense.PDT = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Gelatinous Ring +1",ring2="Warden's Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
    sets.defense.PDT_HP = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}
		
	sets.defense.MDT = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Eabani earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Shadow Ring",
		back=gear.PLDEnm,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.defense.MDT_HP = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Sakpata's breastplate",hands="Sakpata's Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Carrier's Sash",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}

	sets.defense.MEVA = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Purity Ring",ring2="Shadow Ring",
		back=gear.PLDEnm,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.defense.MEVA_HP = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Sakpata's breastplate",hands="Sakpata's Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonbeam Cape",waist="Asklepain Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP,{head="Twilight Helm",body="Twilight Mail"})
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP,{head="Twilight Helm",body="Twilight Mail"})
		
	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {main="Burtgang",sub="Ochain",ammo="Ginsen",
        head="Hjarrandi Helm",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Dagon breastplate",hands="Sakpata's Gauntlets",ring1="Petrov Ring",ring2="Chirich Ring +1",
        back=gear.PLDTP,waist="Tempus Fugit +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}

    sets.engaged.Burtgang = sets.engaged
	sets.engaged.Burtgang.Sakpata = sets.engaged.Sakpata

-- --Burtgang AM3

sets.engaged.Burtgang.MythicAM3 = set_combine(sets.engaged.Burtgang, {ammo="Ginsen",
    head="Hjarrandi Helm",neck="Combatant's Torque",ear1="Telos Earring",ear2="Dedition Earring",
    body="Hjarrandi breastplate",hands="Flamma Manopolas +2",ring1="Flamma Ring",ring2="Chirich Ring +1",
    back=gear.PLDTP,waist="Tempus Fugit +1",legs="Sakpata's cuisses",feet="Flamma Gambieras +2"})



    sets.engaged.Acc = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Sakpata Platemail",hands="Sakpata's Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.PLDTP,waist="Tempus Fugit +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}

    sets.engaged.Sakpata = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Sakpata's breastplate",hands="Sakpata's gauntlets",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=gear.PLDTP,waist="Sailfi belt +1",legs="Sakpata's cuisses",feet="Sakpata's Leggings"}

    sets.engaged.SakpataMDT = {main="Burtgang",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warder's Charm +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Sakpata's breastplate",hands="Sakpata's gauntlets",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=gear.PLDTP,waist="Carrier's Sash",legs="Sakpata's cuisses",feet="Sakpata's Leggings"}

sets.engaged.Sakpata.MythicAM3 = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Combatant's Torque",ear1="Telos Earring",ear2="Dedition Earring",
        body="Sakpata's breastplate",hands="Sakpata's gauntlets",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=gear.PLDTP,waist="Sailfi belt +1",legs="Sakpata's cuisses",feet="Sakpata's Leggings"}

sets.engaged.DW = sets.engaged

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {main="Burtgang",sub="Ochain",ammo="Ginsen",
        head="Hjarrandi Helm",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Dagon breastplate",hands="Sulevia's Gauntlets +2",ring1="Petrov Ring",ring2="Chirich Ring +1",
        back=gear.PLDTP,waist="Tempus Fugit +1",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}
		
	sets.engaged.DDTank = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tartarus Platemail",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=gear.PLDTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
	sets.engaged.Acc.DDTank = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",neck="Loricate Torque +1",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Tartarus Platemail",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=gear.PLDTP,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
	--sets.engaged.NoShellTank = {main="Burtgang",sub="Ochain",ammo="Staunch Tathlum +1",
        --head="Jumalik Helm",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Etiolation Earring",
       -- body="Rev. Surcoat +3",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Moonlight Ring",
      --  back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.odyssean_fc_legs,feet="Cab. Leggings +1"}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
    state.Buff.MythicAM3 = buffactive["Aftermath: Lv. 3"] or false
    sets.buff.MythicAM3 = {ammo="Ginsen",
    head="Hjarrandi Helm",neck="Combatant's Torque",ear1="Telos Earring",ear2="Dedition Earring",
    body="Hjarrandi breastplate",hands="Sakpata's Gauntlets",ring1="Flamma Ring",ring2="Chirich Ring +1",
    back=gear.RudianosTP,waist="Tempus Fugit +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5) --War/Etc
    end
end
function job_buff_change(buff, gain)
  -- AM custom groups
if buff:startswith('Aftermath') then
    if player.equipment.main == 'Burtgang' then
        classes.CustomMeleeGroups:clear()

        if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('MythicAM3')
            add_to_chat(8, '-------------Mythic AM3 UP-------------')
        -- elseif (buff == "Aftermath: Lv.3" and not gain) then
        --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
        end

        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        classes.CustomMeleeGroups:clear()

        if buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end

        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
end
function update_melee_groups()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Burtgang' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('MythicAM3')
        end
    else
        -- relic AM
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
        -- if buffactive['Samurai Roll'] then
        --     classes.CustomRangedGroups:append('SamRoll')
        -- end
    end
end
----
gearswap_box = function()
str = '           \\cs(130,130,130)BuffWatcher\\cr\n'
str = str.."\\cs(255,255,255)  Shihei(U): "..shihei.."\\cr\n"
str = str..'Utsusemi Shadows: '..utsubuff.."\\cr\n"
str = str..'Phalanx: '..phalanxyn.."\\cr\n"
str = str..'Reprisal: '..reprisalyn.."\\cr\n"
str = str..'Cocoon:  '..cocoonyn.."\\cr\n"
return str
 end

-- This is what determines the starting location of the Information Section.
-- Update the X, Y positions to change where this box defaults. Once loaded the box is dragable. 
gearswap_box_config = {pos={x=20,y=240},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

 function user_setup()
 	check_tool_count()
 	gearswap_jobbox:text(gearswap_box())		
 	gearswap_jobbox:show()
 end


 function check_tool_count()
	ctool = {'Shikanofuda',
		'Shihei',
		'Chonofuda',
		'Inoshishinofuda'}

	for t =1,4  do

		if not player.inventory[ctool[t]] then
			curCount = 0
		elseif player.inventory[ctool[t]].count then
			curCount = player.inventory[ctool[t]].count
		end
		a = ''

		--defined green = 99
		cMax = 99
		cColorR = 0
		if curCount > cMax then
			cColorR = 0
			cColorG = 255
		else
			percent = (curCount/cMax * 100)
			if percent >=50 then
				cColorG = 255
				cColorR =math.floor(5 * (100-percent))
			else 
				cColorR = 255
				cColorG = 255-math.floor(5 * (50-percent))
			end
		end
		if curCount == 0 then
			a = "\\cs(255,0,0)" .. '0'
		else 
			a = "\\cs("..cColorR..","..cColorG..",0)" .. (curCount) 
		end

		if t == 1 then
			shika = a
		elseif t == 2 then
			shihei = a
		elseif t == 3 then
			chono = a 
		elseif t == 4 then
			inofu = a 
		end
	end
end
 function buff_change(buff, gain)
 	if buffactive['Copy Image'] then
 		utsubuff = "\\cs(255,127,0)1"	
 	elseif buffactive['Copy Image (2)'] then 
 		utsubuff = "\\cs(255,255,0)2"
 	elseif buffactive['Copy Image (3)'] then
 		utsubuff = "\\cs(127,255,0)3"
 	elseif buffactive['Copy Image (4+)'] then
 		utsubuff = "\\cs(0,255,0)4+"
 	else 
 		utsubuff = "\\cs(255,0,0)0"
     end
     if buffactive['Phalanx'] then
         phalanxyn = "\\cs(0,255,0)Yes"
     else
         phalanxyn ="\\cs(255,127,0)No"
     end
     if buffactive['Reprisal'] then
         reprisalyn = "\\cs(0,255,0)Yes"
     else
         reprisalyn ="\\cs(255,127,0)No"
     end
     if buffactive['Defense Boost'] then
         cocoonyn = "\\cs(0,255,0)Yes"
     else
         cocoonyn ="\\cs(255,127,0)No"
    end

 	gearswap_jobbox:text(gearswap_box())
 	gearswap_jobbox:show()
 end	
 function aftercast(spell, act, spellMap, eventArgs)
	check_tool_count()
    buff_change()
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end 
