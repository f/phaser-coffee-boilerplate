config = require './config.coffee'

class State

  constructor: (game)->

  preload: ->
    # Preload Stage
    @game.stage = $.extend @game.stage, config.stage
    
    # Preload all images
    @game.load.image imageName, path for imageName, path of config.images

  create: ->

    offset = @game.width/4

    @circle1 = @game.add.sprite offset, 0, 'circle'
    @circle2 = @game.add.sprite -offset, 0, 'circle'

    @circle1.anchor.setTo 0.5, 0.5
    @circle2.anchor.setTo 0.5, 0.5
    
    @circle1.tint = 0xFF20A0
    @circle2.tint = 0x256CFF

    @circles = @game.add.group()
    @circles.add @circle1
    @circles.add @circle2

    @circles.x = @game.width/2
    @circles.y = @game.height/2
    
    # Circles
    @blocks = @game.add.group()
    @blocks.createMultiple 5, 'block'
    @blocks.setAll 'scale.y', 6

    @game.physics.arcade.enable @blocks
    @game.physics.arcade.enable @circles

    @timer = @game.time.events.loop 3000, @addBlock, this

    @score = -2
    style = font: '72px Arial', fill:'#ffffff'
    
    @scoreLabel = @game.add.text @game.width/2, @game.height/2, '0', style
    @scoreLabel.anchor.setTo 0.5, 0.5

    @instructionsLabel = @game.add.text @game.width/2, @game.height/2,
      """
      Use left/right arrow keys
      
      
      
      
      Avoid blocks!
      """
    , font: '32px Arial', fill: '#ffffff', align: 'center'
    @instructionsLabel.anchor.setTo 0.5, 0.5

    @game.add.tween(@instructionsLabel).delay(1000).to({alpha: 0}, 1500).start()

    @gameSpeed = 1

  update: ->
    @rotate -1 if @input.keyboard.isDown Phaser.Keyboard.LEFT
    @rotate  1 if @input.keyboard.isDown Phaser.Keyboard.RIGHT

    @game.physics.arcade.overlap @circle1, @blocks, @gameOver, null, this
    @game.physics.arcade.overlap @circle2, @blocks, @gameOver, null, this

  rotate: (angle)->
    @circles.angle += angle*@gameSpeed
    @circle1.angle -= angle*@gameSpeed
    @circle2.angle -= angle*@gameSpeed

  addBlock: ->
    block = @blocks.getFirstDead()
    nth = Math.floor Math.random() * 3

    block.reset @game.width, nth * this.game.height/3
    block.body.velocity.x = -150
    block.checkWorldBounds = yes
    block.outOfBoundsKill = yes

    @score++

    @scoreLabel.text = @score if @score > 0

    @gameSpeed *= 1.02

    @timer.delay /= 1.02

    @blocks.forEachAlive (aliveBlock)=>
      aliveBlock.body.velocity.x = -150 * @gameSpeed

  gameOver: ->
    @game.state.start 'game'
    @game.time.events.remove @timer

module.exports = State
