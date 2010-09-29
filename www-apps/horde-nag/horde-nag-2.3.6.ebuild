# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-nag/horde-nag-2.3.6.ebuild,v 1.2 2010/09/29 19:08:08 a3li Exp $

HORDE_PHP_FEATURES="-o mysql mysqli odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Nag is the Horde multiuser task list manager"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"

src_unpack() {
	horde_src_unpack

	# Remove vtodo specs as they don't install and are not useful to the end user
	rm -r docs/vtodo || die 'removing docs failed'
}
