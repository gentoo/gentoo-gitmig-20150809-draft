# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-0.8.1.ebuild,v 1.1 2005/07/31 23:10:14 carlo Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
SRC_URI="mirror://sourceforge/krecipes/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mysql postgres sqlite"

DEPEND="sqlite? ( dev-db/sqlite )"
RDEPEND="${DEPEND}
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

need-kde 3

pkg_setup() {
	if ! use sqlite && ! use mysql && ! use postgres; then
		eerror krecipes needs either SQLite, MySQL or PostgreSQL to work,
		eerror please try again with USE=\"sqlite\", USE=\"mysql\" or USE=\"postgres\".
		die
	fi
}

src_compile() {
	myconf="$(use_with sqlite) $(use_with mysql) $(use_with postgres postgresql)"

	kde_src_compile
}
