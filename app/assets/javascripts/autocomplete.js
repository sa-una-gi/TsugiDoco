var placeAutoComplete = function(){
    var $target = $(".field");
    $target.autocomplete({
      source: function(req,resp){
        $.ajax({
          url: "/spots/autocomplete",
          type: 'GET',
          dataType: "json",
          data: {keyword: req.term},
          success: function(o){
            var ary = o.map(function(place){
              var hash = {};
              var address = place.address;
              hash = {
              label: place.name + " " + address,
              place_id: place.place_id,
              value: place.name,
              address: address};
              return hash;
            });
            return resp(ary);
          },
          error: function(xhr, ts, err){
            resp(['']);
          }
        });
      },
      select: function( e, ui ){
        e.target.value = ui.item.value;
        var spot_form = $(e.target.closest(".spot_form"));
        spot_form.find("input.place_id").val(ui.item.place_id);
        spot_form.find(".spot_address").val(ui.item.address);
      }
    });
};

jQuery(function(){
  placeAutoComplete();
});