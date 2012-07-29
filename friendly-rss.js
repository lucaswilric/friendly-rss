var http = require('http'),
    fs = require('fs'),
    feeds = {},
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
    
    if (feeds[tag] && now < (feeds[tag].time + 300000)) {
        res.end(feeds[tag].text);
    }
    else {
        http.get("http://grabbit.lucasrichter.id.au/download_jobs/tagged/" + tag + "/feed.rss", 
            function(r) {
                feed = {time: now, text: ''}
                r.on('data', function(chunk) { 
                    var mod_chunk = chunk.toString().replace("<?xml version=\"1.0\"?>", "<?xml version=\"1.0\"?>\n<?xml-stylesheet type=\"text/xsl\" href=\"/rss.xsl\" ?>");
                    feed.text += mod_chunk;
                    res.write(mod_chunk) 
                });
                r.on('end', function() { 
                    res.end(); 
                });
            });
    }
});

var port = process.env.PORT || 5000;
s.listen(port);
console.log("Listening on port " + port);