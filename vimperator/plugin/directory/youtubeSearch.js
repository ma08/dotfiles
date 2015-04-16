(function() {
  liberator.modules.commands.addUserCommand(
    ["youtube"],
    "search from youtube",
    function(args){
      if (args.length === 0) {
        liberator.echo('input a query!');
        return false;
      }

      // make "and" query
      var query = args.join("+");
      var youtubeUrl = 'https://www.youtube.com/results?search_query='
      // open in a new tab
      liberator.open(youtubeUrl + query, liberator.NEW_TAB);
      return false;
    },
    {},
    true
  );
})();
