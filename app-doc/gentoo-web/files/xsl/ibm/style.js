<!--
if ((navigator.appName == "Microsoft Internet Explorer") && (parseInt(navigator.appVersion) >= 4 ))
	if((navigator.appVersion.indexOf("Macintosh"))!= -1)
		document.write('<link rel="stylesheet" href="r1.css" type="text/css"/>')
	else document.write('<link rel="stylesheet" href="ie1.css" type="text/css"/>')
else if ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) >= 4))
	if((navigator.appVersion.indexOf("Macintosh"))!= -1)
		document.write('<link rel="stylesheet" href="r1.css" type="text/css"/>')
	else if ((navigator.appVersion.indexOf("X11"))!= -1)
		document.write('<link rel="stylesheet" href="ln1.css" type="text/css"/>')
	else document.write('<link rel="stylesheet" href="ns1.css" type="text/css"/>')
else document.write('<link rel="stylesheet" href="r1.css" type="text/css"/>')// -->