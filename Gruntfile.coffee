module.exports = (grunt)->

  require('load-grunt-tasks') grunt

  grunt.initConfig
    browserify:
      dist:
        files: 'build/main.js': 'src/main.coffee'
        options:
          transform: ['coffeeify']

    uglify:
      dist:
        files: 'build/main.min.js': 'build/main.js'

    watch:
      coffee:
        files: [
          'src/**/*.coffee',
          'src/**/*.js',
          'assets/**/*.css',
          'assets/**/*.png']
        tasks: ['build']
        options:
          livereload: 1337

    connect:
      server:
        options:
          open: yes
          port: 9001

    clean: dist: files: 'build'

  grunt.registerTask 'build', ['clean', 'browserify', 'uglify']
  grunt.registerTask 'default', ['build', 'connect', 'watch']
