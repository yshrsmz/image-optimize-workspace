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
                ],
            tell:
                files: [
                    {
                        expand: true
                        cwd: 'dist/'
                        src: ['**/*.{png,jpg,gif}']
                        dest: 'dist/'
                    }
                ]
        img2js:
            dice:
                options:
                    imageNamespace: "_g.img.dice"
                src: ["images/diceMapEffectAnimation/*.{png,jpg,gif}"]
                dest: "dist/dice.js"

        # grunt-resource-resizer
        rr:
            all:
                options:
                    sourceRatio: 3
                    output:
                        mdpi:
                            pixelRatio: 1
                            dir: 'drawable-mdpi/'
                        xhdpi:
                            pixelRatio: 2
                            dir: 'drawable-xhdpi/'
                        xxhdpi:
                            pixelRatio: 3
                            dir: 'drawable-xxhdpi/'
                files:
                    './dist/': './images/drawable-xxhdpi/*.png'


    grunt.loadNpmTasks "grunt-image"
    grunt.loadNpmTasks "grunt-resource-resizer"

    grunt.loadTasks "tasks"

    # grunt.registerTask "default", ["image", "img2js"]
    grunt.registerTask "default", ["rr:all", "image:tellme"]
