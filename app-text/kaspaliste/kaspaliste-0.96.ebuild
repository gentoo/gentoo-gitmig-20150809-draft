# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kaspaliste/kaspaliste-0.96.ebuild,v 1.1 2004/12/03 21:10:05 carlo Exp $

inherit kde

DESCRIPTION="A literature database"
HOMEPAGE="http://kaspaliste.sourceforge.net"
SRC_URI="mirror://sourceforge/kaspaliste/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-db/postgresql-7.3"
need-kde 3

pkg_postinst() {
	einfo "You have to create a database named kaspaliste: %createdb kaspaliste."
	einfo "And then import the file kaspaliste/data/create.tables.sql from the kaspaliste directory:"
	einfo "%psql kaspaliste -f create.tables.sql"
}

