import flixel.text.FlxText;

function onLoad() {
    var jefferyshit:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/jefferyshit/jefferyshit'));
    jefferyshit.scale.set(1.1, 1.1);
    jefferyshit.updateHitbox();
    jefferyshit.x = -900;
    jefferyshit.y = -460;
    add(jefferyshit);

    var healthBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/jefferyshit/healthBG'));
    healthBG.x = 10;
    healthBG.y = FlxG.height - healthBG.height - 10;
    if (ClientPrefs.downScroll) healthBG.y = 10;
    healthBG.cameras = [game.camHUD];
    add(healthBG);

    healthTXT = new FlxText(400, 55, FlxG.width - 800, "100", 32);
    healthTXT.setFormat(Paths.font("trebuc"), 110, FlxColor.YELLOW, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.YELLOW);
    healthTXT.x = healthBG.x + 165;
    healthTXT.y = healthBG.y + healthBG.height - 145;
    healthTXT.borderSize = 0;
    healthTXT.cameras = [game.camHUD];
    add(healthTXT);
}

function onCreatePost(){
    game.playHUD.healthBar.visible = false;
    game.playHUD.iconP1.visible = false;
    game.playHUD.iconP2.visible = false;
}

function onUpdate(elapsed){
    var newHealth:Int = Std.int((game.health * 100) / 2);
    if(newHealth > 100) newHealth = 100;
    healthTXT.text = newHealth;
}