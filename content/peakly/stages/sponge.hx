var mainBG3:FlxSprite;
var mainBG2:FlxSprite;
var mainBG1:FlxSprite;

var sponge:BGSprite;
var flashlight:BGSprite;
var black:BGSprite;

var float:Int = 1;

function onLoad(){
    mainBG3 = new BGSprite('stages/sponge/3', -150, 100, 1, 1);
    mainBG3.scale.set(2, 2);
    add(mainBG3);

    mainBG2 = new BGSprite('stages/sponge/2', -150, 100, 1, 1);
    mainBG2.scale.set(2, 2);
    add(mainBG2);

    mainBG1 = new BGSprite('stages/sponge/1', -150, 100, 1, 1);
    mainBG1.scale.set(2, 2);
    add(mainBG1);

    sponge = new BGSprite('stages/sponge/spongebob1', 150, 100, 0.8, 0.8);
    sponge.scale.set(0.3, 0.3);
    add(sponge);

    flashlight = new BGSprite('stages/sponge/flashlight', -370, -200, 0.25, 0.25);
    flashlight.scale.set(0.8, 0.8);
    add(flashlight);

    black = new BGSprite('stages/sponge/black', -370, -200, 0.25, 0.25);
    black.scale.set(0.8, 0.8);
    add(black);

    //i poop
}

function onCreatePost(){
    game.addBehindBF(mainBG3);
    game.addBehindBF(mainBG2);
    game.addBehindBF(mainBG1);
    game.addBehindBF(sponge);
    game.addBehindBF(flashlight);
    game.addBehindBF(black);

    game.playHUD.healthBar.visible = false;
    game.playHUD.iconP1.visible = false;
    game.playHUD.iconP2.visible = false;

    FlxG.camera.follow(game.camFollowPos, sponge, 1);

    game.fuckingHideEveryone();
    game.setGameOverVideo('sponge');
}

function onUpdate(elapsed){
    black.alpha = 1-(game.health/0.5);
}

function onBeatHit(){
    if ((curBeat % 4) != 0) return;
    if(float == 1){
        FlxTween.tween(sponge, {y: 115}, 2.4, {
            ease: FlxEase.quadInOut
        });
        float = -1;
    } else {
        FlxTween.tween(sponge, {y: 85}, 2.4, {
            ease: FlxEase.quadInOut
        });
        float = 1;
    }
}

function onEvent(event, value1, value2){
    if(event == 'Switch Screen') switchScreen(value1);
}

function switchScreen(stage:Int){
    switch(stage){
        case 1:
            mainBG3.destroy();
            trace("faggot");
        case 2:
            mainBG2.destroy();
    }
}