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
                <div class="span10 offset1">
                    <h3><span class="icon-chevron-right"></span
                        ><a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="link"/>
                            </xsl:attribute>
                            <xsl:value-of select="title"/>
                        </a>
                    </h3>
                </div>
            </div>
          </xsl:for-each>
        </div>
		<hr style="clear: both;" />
		<div id="footer">
			<p>This page is styled after <a href="http://scripting.com/">Dave Winer</a>'s <a href="http://daveriver.scripting.com/">River of News</a>. It's built with <a href="http://jquery.com">jQuery</a> and <a href="http://twitter.github.com/bootstrap/">Bootstrap</a>, and gets its data from <a href="http://grabbit.lucasrichter.id.au/">Grabbit</a>.</p>
		</div>
	</section>
	<script type="text/javascript" src="http://assets.lucasrichter.id.au/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	$(function() {
	    $.each($('.item a'), function() {
	        var url = $(this).attr('href').replace(/https?:\/\//, '');
	        var domain = url.substring(0,url.indexOf('/'));
	        var i = $(document.createElement('img'));
	        i.attr('src', 'http://www.google.com/s2/favicons?domain='+domain).attr('class', 'domain-icon').prependTo($(this).closest('.item').find('h3'));
	    });
	});
	</script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>