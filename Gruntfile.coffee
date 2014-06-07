module.exports = (grunt) ->
    pkg = grunt.file.readJSON 'package.json'
    grunt.initConfig

        # grunt-image
        image:
            createjs:
                files: [
                    {
                        expand: true
                        cwd: 'images/'
                        src: ['**/*.{png,jpg,gif}']
                        dest: 'dist/'
                    }
                ]
        img2js:
            diceMapEffect:
                options:
                    imageNamespace: "_g.img.diceMapEffectAnimation"
                src: ["images/diceMapEffectAnimation/*.{png,jpg,gif}"]
                dest: "dist/dice-map-effect-animation-img.js"


    grunt.loadNpmTasks "grunt-image"
    grunt.loadNpmTasks "grunt-contrib-coffee"

    grunt.loadTasks "tasks"

    grunt.registerTask "default", ["image", "img2js"]