# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-imp/horde-imp-3.2.2.ebuild,v 1.10 2004/01/27 00:57:20 vapier Exp $

inherit horde

DESCRIPTION="Horde IMP provides webmail access to IMAP/POP3 mailboxes"

KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.4"

pkg_setup() {
	# FIXME: Is this really how we want to do this ?
	GREP=`grep imap /var/db/pkg/dev-php/mod_php*/USE`
	if [ "${GREP}" != "" ]; then
		return 0
	else
		eerror "Missing IMAP support in mod_php !"
		die "aborting..."
	fi
	horde_pkg_setup
}
