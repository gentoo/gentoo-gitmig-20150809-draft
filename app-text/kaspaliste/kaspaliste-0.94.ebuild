# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kaspaliste/kaspaliste-0.94.ebuild,v 1.4 2004/06/04 15:40:30 carlo Exp $

inherit kde

DESCRIPTION="A literature database"
HOMEPAGE="http://kaspaliste.sourceforge.net"
SRC_URI="http://kaspaliste.sourceforge.net/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-db/postgresql-7.3"

pkg_postinst() {
	einfo "You have to create a database named kaspaliste: %createdb kaspaliste."
	einfo "And then import the file kaspaliste/data/create.tables.sql from the kaspaliste directory:"
	einfo "%psql kaspaliste -f create.tables.sql"
}

