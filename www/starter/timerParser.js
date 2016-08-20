/** 
* 获取本周、本季度、本月、上月的开端日期、停止日期 
*/ 
    var now = new Date(); //当前日期 
    var nowDayOfWeek = now.getDay(); //今天本周的第几天 
    var nowDay = now.getDate(); //当前日 
    var nowMonth = now.getMonth(); //当前月 
    var nowYear = now.getYear(); //当前年 
    nowYear += (nowYear < 2000) ? 1900 : 0; // 

    var lastMonthDate = new Date(); //上月日期 
    lastMonthDate.setDate(1); 
    lastMonthDate.setMonth(lastMonthDate.getMonth()-1); 
    var lastYear = lastMonthDate.getYear(); 
    var lastMonth = lastMonthDate.getMonth(); 

    //格局化日期：yyyy-MM-dd 
    var formatDate = function (date) { 
        var myyear = date.getFullYear(); 
        var mymonth = date.getMonth()+1; 
        var myweekday = date.getDate(); 

        if(mymonth < 10){ 
            mymonth = "0" + mymonth; 
        } 
        if(myweekday < 10){ 
            myweekday = "0" + myweekday; 
        } 
        return (myyear + "-" + mymonth + "-" + myweekday); 
    } 
    var formatChinese = function (date) { 
        var myyear = date.getFullYear(); 
        var mymonth = date.getMonth()+1; 
        var myweekday = date.getDate(); 

        // if(mymonth < 10){ 
        //     mymonth = "0" + mymonth; 
        // } 
        // if(myweekday < 10){ 
        //     myweekday = "0" + myweekday; 
        // } 

        return (/*myyear + "年" +*/ mymonth + "月" + myweekday + '日');         
    } 

    //获得某月的天数 
    var getMonthDays = function (myMonth){ 
        var monthStartDate = new Date(nowYear, myMonth, 1); 
        var monthEndDate = new Date(nowYear, myMonth + 1, 1); 
        var days = (monthEndDate - monthStartDate)/(1000 * 60 * 60 * 24); 
        return days; 
    } 

    //获得本季度的开端月份 
    var getQuarterStartMonth = function (){ 
        var quarterStartMonth = 0; 
        if(nowMonth<3){ 
        quarterStartMonth = 0; 
        } 
        if(2<nowMonth && nowMonth<6){ 
        quarterStartMonth = 3; 
        } 
        if(5<nowMonth && nowMonth<9){ 
        quarterStartMonth = 6; 
        } 
        if(nowMonth>8){ 
        quarterStartMonth = 9; 
        } 
        return quarterStartMonth; 
    } 

    //获得一周
    var wholeWeek = function (now) { 
        var nowDayOfWeek = now.getDay(); //今天本周的第几天 
        var nowDay = now.getDate(); //当前日 
        var nowMonth = now.getMonth(); //当前月 
        var nowYear = now.getYear(); //当前年 
        nowYear += (nowYear < 2000) ? 1900 : 0; // 
        var result = [];
        for(var i=0;i<7;i++){
            result.push({
                date:formatDate(new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + i + 1)),
                dateInChinese:formatChinese(new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + i + 1))+' 周'+(i+1)
                });
        }
        return result;
    }
 

    //获得本周的开端日期 
    var getWeekStartDate = function () { 
        var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek); 
        return [formatDate(weekStartDate),formatChinese(weekStartDate)]; 
    } 

    //获得本周的停止日期 
    var getWeekEndDate = function () { 
        var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek)); 
        return [formatDate(weekEndDate),formatChinese(weekEndDate)]; 
    } 
    //获得指定周的开端日期 
    var getCertainWeekStartDate = function (text) { 
        var now = new Date(text); //当前日期 
        var nowDayOfWeek = now.getDay(); //今天本周的第几天 
        var nowDay = now.getDate(); //当前日 
        var nowMonth = now.getMonth(); //当前月 
        var nowYear = now.getYear(); //当前年 
        nowYear += (nowYear < 2000) ? 1900 : 0; // 
        var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1); 
        return formatDate(weekStartDate); 
    } 

    //获得指定周的停止日期 
    var getCertainWeekEndDate = function (text) { 
        var now = new Date(text); //当前日期 
        var nowDayOfWeek = now.getDay(); //今天本周的第几天 
        var nowDay = now.getDate(); //当前日 
        var nowMonth = now.getMonth(); //当前月 
        var nowYear = now.getYear(); //当前年 
        nowYear += (nowYear < 2000) ? 1900 : 0; // 

        var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek) + 1); 
        return formatDate(weekEndDate); 
    }

    //获得本月的开端日期 
    var getMonthStartDate = function (){ 
        var monthStartDate = new Date(nowYear, nowMonth, 1); 
        return [formatDate(monthStartDate),formatChinese(monthStartDate)]; 
    } 

    //获得本月的停止日期 
    var getMonthEndDate = function (){ 
        var monthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth)); 
        return [formatDate(monthEndDate),formatChinese(monthEndDate)]; 
    } 
    
    
    //获得指定月的开端日期 
    var getCertainMonthStartDate = function (certainMonth){ 
        var monthStartDate = new Date(nowYear, certainMonth, 1); 
        return [formatDate(monthStartDate),formatChinese(monthStartDate)]; 
    } 
    
    //获得指定月的停止日期 
    var getCertainMonthEndDate = function (certainMonth){ 
        var monthEndDate = new Date(nowYear, certainMonth, getMonthDays(certainMonth)); 
        return [formatDate(monthEndDate),formatChinese(monthEndDate)]; 
    }


    //获得上月开端时候 
    var getLastMonthStartDate = function (){ 
        var lastMonthStartDate = new Date(nowYear, lastMonth, 1); 
        return [formatDate(lastMonthStartDate),formatChinese(lastMonthStartDate)]; 
    } 

    //获得上月停止时候 
    var getLastMonthEndDate = function (){ 
        var lastMonthEndDate = new Date(nowYear, lastMonth, getMonthDays(lastMonth)); 
        return [formatDate(lastMonthEndDate),formatChinese(lastMonthEndDate)]; 
    } 

    //获得本季度的开端日期 
    var getQuarterStartDate = function (){ 

        var quarterStartDate = new Date(nowYear, getQuarterStartMonth(), 1); 
        return [formatDate(quarterStartDate),formatChinese(quarterStartDate)]; 
    } 

    //或的本季度的停止日期 
    var getQuarterEndDate = function (){ 
        var quarterEndMonth = getQuarterStartMonth() + 2; 
        var quarterStartDate = new Date(nowYear, quarterEndMonth, getMonthDays(quarterEndMonth)); 
        return [formatDate(quarterStartDate),formatChinese(quarterStartDate)]; 
    }

    //当前的周数
    var getYearWeek=function (text){  
        var date = new Date(text);
        var date2=new Date(date.getFullYear(), 0, 1);  
        var day1=date.getDay();  
        if(day1==0) day1=7;  
        var day2=date2.getDay();  
        if(day2==0) day2=7;  
        d = Math.round((date.getTime() - date2.getTime()+(day2-day1)*(24*60*60*1000)) / 86400000);    
        return Math.ceil(d /7)+1;   
    }  

    //当月第一天所在周 startweek 和当月最后一天所在周 endweek
    // for(var i=startweek ; i<=endweek;i++){

    // }
    var dateAdd = function (dateText,addNum) { 
        var now = new Date(dateText); //当前日期 
        var nowDay = now.getDate(); //当前日 
        var nowMonth = now.getMonth(); //当前月 
        var nowYear = now.getYear(); //当前年 
        nowYear += (nowYear < 2000) ? 1900 : 0; // 
        var finalDate = new Date(nowYear, nowMonth, nowDay  + addNum); 
        return formatDate(finalDate); 
    }
    module.exports={
        getYearWeek:getYearWeek,
        wholeWeek:wholeWeek,
        // wholeWeekInChinese:wholeWeekInChinese,
        // WeekStartTime:getWeekStartTime,
        // WeekEndTime:getWeekEndTime,
        WeekStart:getWeekStartDate,
        WeekEnd:getWeekEndDate,
        MonthStart:getMonthStartDate,
        MonthEnd:getMonthEndDate,
        getCertainMonthStartDate:getCertainMonthStartDate,
        getCertainMonthEndDate:getCertainMonthEndDate,
        getCertainWeekStartDate:getCertainWeekStartDate,
        getCertainWeekEndDate:getCertainWeekEndDate,
        dateAdd:dateAdd,
    };

