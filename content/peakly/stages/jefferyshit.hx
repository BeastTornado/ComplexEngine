import flixel.text.FlxText;

var beatnado:FlxSprite;
var youtube:FlxSprite;
var beatnadoAdded:Bool = false;
var healthBG:FlxSprite;
var timeBar:Bar;

var anims:Array<String> = [
    'left',
    'down',
    'up',
    'right',
    'idle',
    'freaky'
];

function onLoad() {
    var jefferyshit:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/jefferyshit/jefferyshit'));
    jefferyshit.scale.set(1.1, 1.1);
    jefferyshit.updateHitbox();
    jefferyshit.x = -900;
    jefferyshit.y = -460;
    add(jefferyshit);

    healthBG = new FlxSprite().loadGraphic(Paths.image('stages/jefferyshit/healthBG'));
    healthBG.x = 10;
    healthBG.y = FlxG.height - healthBG.height - 10;
    healthBG.cameras = [game.camHUD];
    add(healthBG);

    healthTXTliteral = new FlxText(0, 0, FlxG.width - 800, "Health", 32);
    healthTXTliteral.setFormat(Paths.font("halflife2"), 50, FlxColor.YELLOW, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.YELLOW);
    healthTXTliteral.x = healthBG.x + 10;
    healthTXTliteral.y = FlxG.height - 70;
    healthTXTliteral.borderSize = 0;
    healthTXTliteral.cameras = [game.camHUD];
    add(healthTXTliteral);

    healthTXT = new FlxText(0, 0, FlxG.width - 800, "100", 32);
    healthTXT.setFormat(Paths.font("halflife2"), 110, FlxColor.YELLOW, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.YELLOW);
    healthTXT.x = healthBG.x + 165;
    healthTXT.y = healthBG.y + healthBG.height - 145;
    healthTXT.borderSize = 0;
    healthTXT.cameras = [game.camHUD];
    add(healthTXT);

    beatnado = new FlxSprite();
    beatnado.frames = Paths.getSparrowAtlas('characters/ytbeast');
    for(i in 0...anims.length){
        beatnado.animation.addByPrefix(anims[i], 'ytbeast ' + anims[i], 12, false);
    }
    beatnado.scale.set(0.4, 0.4);
    beatnado.updateHitbox();
    beatnado.x = 0;
    beatnado.y = 0;
    beatnado.cameras = [game.camHUD];

    youtube = new FlxSprite().loadGraphic(Paths.image('stages/jefferyshit/youtube'));
    youtube.x = (FlxG.width/2) - (youtube.width/2);
    youtube.y = FlxG.height - youtube.height;
    youtube.cameras = [game.camHUD];

    timeBar = new Bar(0, 0, 'timeBar', function() return game.songPercent, 0, 1);
    timeBar.scrollFactor.set();
    timeBar.barWidth = FlxG.width;
    timeBar.barHeight = 10;
    timeBar.screenCenter(X);
    timeBar.y = youtube.y + timeBar.height;
    timeBar.alpha = 0;
}

function onCreatePost(){
    game.playHUD.healthBar.visible = false;
    game.playHUD.iconP1.visible = false;
    game.playHUD.iconP2.visible = false;

    for (i in 0...game.opponentStrums.members.length) {
		game.opponentStrums.members[i].visible = false;
	}
}

function onBeatHit(){
    if ((curBeat % 2) != 0) return;

    if(!beatnadoAdded) return;
    beatnado.animation.play('idle');
}

function onUpdate(elapsed){
    var newHealth:Int = Std.int((game.health * 100) / 2);
    if(newHealth > 100) newHealth = 100;
    healthTXT.text = newHealth;
}

function goodNoteHit(note){
    if(!beatnadoAdded) return;
    beatnado.animation.play(anims[note.noteData]);
}

function onEvent(event, value1, value2){
    if(event == 'ytpoop'){
        FlxG.cameras.flash(FlxColor.WHITE, 0.4, true);
        game.opponentStrums.alpha = 0;
        beatnadoAdded = true;
        add(beatnado);
        add(youtube);
        add(timeBar);
        game.playHUD.scoreTxt.visible = false;
        healthBG.y = youtube.y - healthBG.height;
        healthTXT.y = healthBG.y + healthBG.height - 145;
        healthTXTliteral.y = FlxG.height - 70;
    }
}

function onSpawnNotePost(note:Note)
    {
        note.visible = note.mustPress;
    }