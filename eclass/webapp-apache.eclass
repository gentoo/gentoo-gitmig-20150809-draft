# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/webapp-apache.eclass,v 1.1 2003/08/03 19:20:11 stuart Exp $
#
# Author: Stuart Herbert <stuart@gentoo.org>
# 
# Based on discussions held on gentoo-dev mailing list, and a bug report
# contributed by <??> in bug #14870, and robbat2's mod_php ebuild

ECLASS=webapp-apache
INHERITED="$INHERITED $ECLASS"

# NOTE:
#
# It is deliberate that the functions in this eclass are called
# 'webapp-xxx' rather than 'webapp-apache-xxx'.  This ensures
# that we can drop in eclasses for other web servers without
# having to change the ebuilds!

function webapp-apache-detect ()
{
	local domsg=
	[ -n "$1" ] && domsg=1

	APACHEVER=
	has_version '=net-www/apache-1*' && APACHEVER=1
	has_version '=net-www/apache-2*' && use apache2 && APACHEVER=2
	[ -z "${APACHEVER}" ] && has_version '=net-www/apache-2*' && APACHEVER=2

	if [ "${APACHEVER}+" = "+" ]; then
		# no apache version detected
		eerror "I can't find a copy of Apache on your machine"
		die 1
	fi

	APACHECONF="/etc/apache${APACHEVER}/conf/apache${APACHEVER}.conf"
	WEBAPP_SERVER="Apache v${APACHEVER}"
}

# run the function, so we know which version of apache we are using
webapp-apache-detect

function webapp-determine-htdocsdir ()
{
	webapp-determine-installowner

	HTTPD_ROOT="`grep '^DocumentRoot' ${APACHECONF} | cut -d ' ' -f 2`"
	[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
	keepdir "$HTTPD_ROOT"
	fowners "$HTTPD_USER"."$HTTPD_GROUP" "$HTTPD_ROOT"
	fperms 755 "$HTTPD_ROOT"
}

function webapp-determine-installowner ()
{
	HTTPD_USER="apache"
	HTTPD_GROUP="apache"
}

