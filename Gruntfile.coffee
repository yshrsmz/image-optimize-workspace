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
                        src: ['*.{png,jpg,gif}']
                        dest: 'dist/'
                    }
                ]


    grunt.loadNpmTasks 'grunt-image'