# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-turba/horde-turba-1.2.1.ebuild,v 1.10 2004/01/27 00:59:30 vapier Exp $

inherit horde

DESCRIPTION="Turba is the Horde address book / contact management program"

KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.4"

pkg_setup() {
	GREPBACKEND=`egrep 'sql|odbc|postgres|ldap' /var/db/pkg/dev-php/mod_php*/USE`
	if [ -z "${GREPBACKEND}" ] ; then
		eerror "Missing SQL or LDAP support in mod_php !"
		die "aborting..."
	fi
	horde_pkg_setup
}
