# $Header: /var/cvsroot/gentoo-x86/eclass/apache.eclass,v 1.1 2003/06/11 20:13:17 brad Exp $
#
# Author: Brad Laue <brad@gentoo.org>

#allow users to customize their data directory by setting the
#home directory of the 'apache' user elsewhere.

ECLASS=apache
INHERITED="$INHERITED $ECLASS"


get_docroot () {

	DOCROOT=`grep ^apache: /etc/passwd | cut -d: -f6`
	if [ -z "$DOCROOT" ]
	then
	    DOCROOT="/home/httpd"
	    eerror "Please create the apache user and set his home"
	    eerror "directory to your desired datadir location."
	    eerror "Defaulting to \"/home/httpd\"."
	else
	    einfo "$DOCROOT is your Apache data directory ..."
	fi
}
