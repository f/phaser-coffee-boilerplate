State = require './lib/state.coffee'
config = require './lib/config.coffee'

$(document).ready ->

  demo = new Phaser.Game config.width, config.height, Phaser.AUTO
  demo.state.add 'game', State, yes
