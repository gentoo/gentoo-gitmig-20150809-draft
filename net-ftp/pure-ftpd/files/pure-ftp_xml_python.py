#! /usr/bin/python2
#Script by j@falooley.org (Jason Lunz) in the contrib section of pure-ftp

    import os
    from xml.sax import handler, make_parser

    class ftpwho_handler(handler.ContentHandler):
	def __init__(self):
	    handler.ContentHandler.__init__(self)
	    self.clear()

	def startElement(self, name, attrs):
	    if name != 'client': return
	    d = {}
	    for (k, v) in attrs.items():
		d[k] = v
	    self.clients.append(d)

	def clear(self):
	    self.clients = []

    parser = make_parser()
    fh = ftpwho_handler()
    parser.setContentHandler(fh)

    def numberize(dicts):
	for c in dicts:
	    for k in ('pid', 'time', 'localport', 'percentage', 'bandwidth'):
		if c.has_key(k):
		    c[k] = int(c[k])
	    for k in ('current_size', 'resume', 'total_size'):
		if c.has_key(k):
		    c[k] = long(c[k])
	return dicts

    def clients():
	fh.clear()
	parser.parse(os.popen('pure-ftpwho -x'))
	return numberize(fh.clients)


