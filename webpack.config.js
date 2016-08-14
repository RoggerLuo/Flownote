module.exports = {
    entry : './www/js/app.js',
    output :{
        path :'./www/build',
        filename :"bundle.js"
    },
    module :{
        loaders :[
            {
                test :/\.coffee$/,
                loader :"coffee",
                excelude :/node_modules/,
            }
        ]
    }
};
