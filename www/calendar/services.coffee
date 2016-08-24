module.exports=angular.module 'calendar.services',[]
.factory 'GetDailySummary', (Resource)->
    execute = (startweek)->
        Resource.query({method:'get_summary',start:startweek}).$promise
    execute

.factory 'UpdateDailySummary', (Resource)->
    execute = (date,content)->
        Resource.query({method:'update_summary',date:date,content:content}).$promise
    execute

.factory 'GetWeeklySummary', (Resource)->
    execute = (weeknumber,end_weeknumber)->
        Resource.query({method:'get_week_summary',weeknumber:weeknumber,end_weeknumber:end_weeknumber}).$promise
    execute

.factory 'UpdateWeeklySummary', (Resource)->
    execute = (weeknumber,content)->
        Resource.query({method:'update_week_summary',weeknumber:weeknumber,content:content}).$promise
    execute

