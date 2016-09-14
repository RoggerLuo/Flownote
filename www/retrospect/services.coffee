module.exports=angular.module 'retrospect.services',[]

.factory 'GetArtNumOfMonth', (Resource)->
    execute = ->
        Resource.query({method:'get_num_of_diff_month'}).$promise
    execute

.factory 'GetArtNumOfCate', (Resource)->
    execute = ->
        Resource.query({method:'get_num_of_diff_cate'}).$promise
    execute
