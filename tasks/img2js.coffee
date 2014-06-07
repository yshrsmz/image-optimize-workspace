async = require "async"
fs = require "fs"
handlebars = require "handlebars"
path = require "path"

templateFile = fs.readFileSync __dirname + "/img2js.handlebars", "utf8"
template  = handlebars.compile templateFile

supportedExtensions = [".jpg", ".jpeg", ".png", ".gif"]

encodeBase64 = (path) ->
    imageBin = fs.readFileSync path
    new Buffer(imageBin).toString("base64")

module.exports = (grunt) ->

    grunt.registerMultiTask "img2js",
        "encode provided images to base64 strings, and convert to LoadQueue compatible js file.",
        ->
            options = this.options(
                imageNamespace: 'images'
            )

            that  = @

            done = @async()

            async.forEachSeries @files, (file, callback) ->
                srcFiles = grunt.file.expand file.src
                dest = file.dest
                templateData =
                    images: []
                    imageNamespace: options.imageNamespace

                srcFiles.forEach (_file) ->
                    if fs.statSync(_file).isFile()
                        _basename = path.basename _file
                        _ext = path.extname _file

                        # not hidden file, supported file extension
                        if _basename.indexOf(".") isnt 0 and supportedExtensions.indexOf(_ext) >= 0

                            imageData =
                                name: path.basename _basename, _ext
                                ext: _ext.slice(1)
                                src: encodeBase64 _file

                            templateData.images.push imageData

                ret = template templateData

                # output file
                fs.writeFile dest, ret, (err) ->
                    if err
                        throw err
                    else
                        console.log "images are converted and written to", dest
                        callback()
            ,done

