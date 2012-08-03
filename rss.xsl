<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.0">
<xsl:template match="/rss/channel">
<html>
<head>
  <title><xsl:value-of select="title"/></title>
 <link rel="stylesheet" type="text/css" href="http://assets.lucasrichter.id.au/bootstrap/css/bootstrap.css" />
 <link rel="stylesheet" type="text/css" href="http://assets.lucasrichter.id.au/css/rss.css" />
</head>
<body>
	<section id="grid-system">
		<div class="page-header row">
		<h1 class="span10"><xsl:value-of select="title"/></h1><a id="rss-icon" class="span1" href="/"><img src="http://assets.lucasrichter.id.au/img/feed-icon-28x28.png" /></a></div>
		<div id="news">
          <xsl:for-each select="item">
            <div class="item row">
                <xsl:attribute name="pub-date">
                    <xsl:value-of select="pubDate"/>
                </xsl:attribute>
                <div class="span10 offset1">
                    <h3><span class="icon-chevron-right"></span
                        ><a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="link"/>
                            </xsl:attribute>
                            <xsl:value-of select="title"/>
                        </a>
                    </h3>
                    <xsl:if test="source">
                        <span class="link-attribution">
                            from
                            <em>
                                <xsl:value-of select="source"/>
                            </em>
                        </span>
                    </xsl:if>
                </div>
            </div>
          </xsl:for-each>
        </div>
		<hr style="clear: both;" />
		<div id="footer">
			<p>This page is styled after <a href="http://scripting.com/">Dave Winer</a>'s <a href="http://daveriver.scripting.com/">River of News</a>. It's built with <a href="http://jquery.com">jQuery</a> and <a href="http://twitter.github.com/bootstrap/">Bootstrap</a>, and gets its data from <a href="http://grabbit.lucasrichter.id.au/">Grabbit</a>.</p>
		</div>
	</section>
	<div id="templates">
		<div id="date-header-template" class="day-header row">
			<h2 class="offset1"></h2>
		</div>
	</div>
	<script type="text/javascript" src="http://assets.lucasrichter.id.au/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	$(function() {
	    window.last_pub_date = '';
	    $.each($('.item'), function() {
            var $this = $(this);
	        var url = $this.find('a').attr('href').replace(/https?:\/\//, '');
	        var domain = url.substring(0,url.indexOf('/'));
	        var i = $(document.createElement('img'));
	        i.attr('src', 'http://www.google.com/s2/favicons?domain='+domain).attr('class', 'domain-icon').prependTo($this.find('h3'));
	        
	        var pub_date = $this.attr('pub-date');
	        pub_date = pub_date.substring(0,pub_date.indexOf('201')+4);
	        if (pub_date !== window.last_pub_date) {
                window.last_pub_date = pub_date;
                var header = $('#date-header-template').clone().attr('id', null);
                header.find('h2').text(pub_date);
                header.prependTo($this);
            }
	    });
	});
	</script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>