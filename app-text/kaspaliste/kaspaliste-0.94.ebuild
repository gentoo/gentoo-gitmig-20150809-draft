# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kaspaliste/kaspaliste-0.94.ebuild,v 1.2 2004/01/15 18:06:59 lanius Exp $

inherit kde-base

DESCRIPTION="A litterature database"
SRC_URI="http://kaspaliste.sourceforge.net/${P}.tar.bz2"
HOMEPAGE="http://kaspaliste.sourceforge.net"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=dev-db/postgresql-7.3"

pkg_postinst() {
	einfo "You have to create a database named kaspaliste: %createdb kaspaliste."
	einfo "And then import the file kaspaliste/data/create.tables.sql from the kaspaliste directory:"
	einfo "%psql kaspaliste -f create.tables.sql"
}
