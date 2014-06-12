# Phaser CoffeeScript + Browserify + LiveReload Development Boilerplate

It's a very simple boilerplate for Phaser framework, including the example of [@demircancelebi][1]'s Together game.

## Installation

To start using Phaser with CoffeeScript easily,
```bash
git clone https://github.com/f/phaser-coffee-boilerplate my-game
cd my-game
bower install
npm install
grunt
```

## main.coffee

main.coffee is your main file. You should write your game's HTML presentational parts here. Since this boilerplate uses **browserify**
you can/should use `require` function of Node.js easily. TL,DR; it's main file.

## config.coffee

This is a simple JSON exporting JS file. So you can put some logic if you need.

## state.coffee

This is the main logic of your game. Everything happens here.

```coffeescript
config = require './config.coffee'

class State

  constructor: (game)->

  preload: ->
    # Preload Stage
    @game.stage = $.extend @game.stage, config.stage
    
    # Preload all images from config file
    @game.load.image imageName, path for imageName, path of config.images

  create: ->
  
    # Create world.

  update: ->

    # Living world.

module.exports = State
```

Have fun! :)

[1]: https://github.com/demircancelebi

# License

MIT.
