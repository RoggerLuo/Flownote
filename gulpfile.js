var gulp = require('gulp');
var webpack = require("webpack");
var webpackConfig = require("./webpack.config.js");
var uglify = require('gulp-uglify'); 
var ngAnnotate = require('gulp-ng-annotate');

gulp.task("webpack", function(callback) {
    var myConfig = Object.create(webpackConfig);
    // run webpack
    webpack(
        // configuration 其实直接写require后的config文件也可以
        // myConfig
        webpackConfig
    , function(err, stats) {
        callback(err);
    });
});

gulp.task('uglify',['webpack'],function() {  
    return gulp.src('www/build/bundle.js') //注意，此处特意如此，避免顺序导致的问题
        .pipe(ngAnnotate())
        .pipe(uglify({outSourceMap: false}))  
        .pipe(gulp.dest('www/build/'))  
});   

gulp.task('default', ['webpack','uglify']);


var
    jslint = require('gulp-jslint'),
    gulp = require('gulp');

gulp.task('jslint', function () {
    return gulp.src([
        './www/thread/*.js',
        './www/article/*.js',
        './www/calendar/*.js',
        './www/editor/*.js',
        './www/entry/*.js',
        './www/setting/*.js',
        './www/*.js'
    ]).pipe(jslint({
        node: true,
        nomen: true,
        sloppy: true,
        plusplus: true,
        unparam: true,
        stupid: true
    }));
});
