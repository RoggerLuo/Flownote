module.exports = {
    entry : './www/entry/app.coffee',
    output :{
        path :'./www/build',
        filename :"bundle.js"
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
                   test   : /\.woff|\.woff2|\.svg|.eot|\.ttf/,
                   loader : 'url?prefix=font/&limit=10000',
                   excelude :/node_modules/
            },
            { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192',excelude :/node_modules/}
        ]
    }
};
