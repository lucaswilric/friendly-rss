var http = require('http'),
    fs = require('fs'),
    xsl = '';

fs.readFile('rss.xsl', function(err, data) {
    if (err) throw err;
    xsl = data.toString();
});

var s = http.createServer(function(req, res) {
    var tag = req.headers['host'].split(/[:.]+/)[0],
        now = new Date();
        
    if (req.url === "/rss.xsl") {
        res.writeHead(200, {'content-type': 'text/xsl'});
        res.end(xsl);
        return;
    }
    
    res.writeHead(200, { 'content-type': 'application/xml' });
    
    http.get("http://grabbit.lucasrichter.id.au/download_jobs/tagged/" + tag + "/feed.rss", 
        function(r) {
            r.on('data', function(chunk) { 
                var mod_chunk = chunk.toString().replace("<?xml version=\"1.0\"?>", "<?xml version=\"1.0\"?>\n<?xml-stylesheet type=\"text/xsl\" href=\"/rss.xsl\" ?>");
                res.write(mod_chunk) 
            });
            r.on('end', function() { 
                res.end(); 
            });
        });
    });

var port = process.env.PORT || 5000;
s.listen(port);
console.log("Listening on port " + port);