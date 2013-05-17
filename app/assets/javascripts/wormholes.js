$('.typeahead.wh').typeahead({
  source: function(q,p) {
    $.ajax({
      type:'GET',
      url: '/wormholes/q.json?name='+q,
      dataType: "json",
      success: function(data) {
        nl = [];
        for (d in data)
        {
          nl.push(data[d].name);
        }
        return p(nl);
      }
    });
  }
});
