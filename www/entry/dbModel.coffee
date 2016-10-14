module.exports=angular.module 'app.dbModel',[]
.factory 'Db',(RemoveFunc)->
    db = {
        items:[]
    }
    items = {}    
    items.query = (filterObj)->
        return db.items.filter (el)->
            return runFilters el,filterObj
    items.remove = (item)->
        return RemoveFunc.call db.items,item
    items.insert = (item)->
        db.items.push item
    items.load = (data)->
        db.items = data

    runFilters = (el,filterObj)-> #filters = {type:type,thread:thread,ready:true}
        typeMatch = true
        threadMatch = true
        readyMatch = true
        monthMatch = true
        if filterObj.type? 
            typeMatch = el.type.toString() == filterObj.type.toString()
        if filterObj.thread? 
            threadMatch = el.thread_id.toString() == filterObj.thread.toString()
        if filterObj.ready
            distance = Date.parse(new Date()) - el.remind_time*1000
            readyMatch = distance > 0
        if filterObj.month?
            date = new Date(el.date_and_time*1000) 
            month = date.getMonth()+1
            monthMatch= month.toString() == parseInt(filterObj.month).toString()
        return typeMatch && threadMatch && readyMatch && monthMatch

    return {
        items:items
    }
