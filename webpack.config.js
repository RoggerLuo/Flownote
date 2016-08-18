module.exports = {
    entry : './www/entry/app.coffee',
    output :{
        path :'./www/build', //这个是以wabpack.config.js为当前路径
        filename :"bundle.js",
        publicPath: "./build/" //貌似这个是以index为当前路径
    },
    module :{
        loaders :[
            {
                test :/\.coffee$/,
                loader :"coffee",
                excelude :/node_modules/
            },
            { 
                test: /\.css$/, 
                loader: "style!css",
                excelude :/node_modules/
            },
            {
                test   : /\.woff/,
                loader : 'url'
            }, {
                test   : /\.ttf/,
                loader : 'file'//?name=[name].[ext]
            }, {
                test   : /\.eot/,
                loader : 'file'
            }, {
                test   : /\.svg/,
                loader : 'file'
            }
        ]
    }
};
