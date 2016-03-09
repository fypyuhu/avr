$.getJSON("http://suggestqueries.google.com/complete/search?callback=?",
    { 'hl':'en', 'jsonp':'suggestCallBack', 'q':'hello', 'client':'youtube', 'ds':'yt', 'gl':'us' } );


suggestCallBack = function (data) {

        $("#modal_body").html(data);

};
   