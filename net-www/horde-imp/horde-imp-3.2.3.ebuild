# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-imp/horde-imp-3.2.3.ebuild,v 1.3 2004/03/29 01:34:14 zx Exp $

inherit horde

DESCRIPTION="Horde IMP provides webmail access to IMAP/POP3 mailboxes"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.5"

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
