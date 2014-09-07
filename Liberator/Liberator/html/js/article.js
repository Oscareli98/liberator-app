$(document).ready(function() {
    $.expr[":"].contains = $.expr.createPseudo(function(arg) {
        return function( elem ) {
            return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
        };
    });
    $('.feature-image').lazyload({
      effect : "fadeIn"
    });
    $('p:contains("story by")').hide();
    if($('p:contains("story by")').length){
        $('p.author').text($('p:contains("story by")').text());
    }
});