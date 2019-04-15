/**
* @author: ${author}
* @date: ${date?string('yyyy/MM/dd hh:mm:ss')}
* @modified by:
**/
$(function () {
var existRecord;
    if (EXIST_RECORD_JSON && EXIST_RECORD_JSON != '') {
        existRecord = JSON.parse(EXIST_RECORD_JSON);
        if (existRecord) {
            way.set("record", existRecord);
        });
    }
});
