# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-0.7.ebuild,v 1.1 2005/02/13 17:45:12 greg_g Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
SRC_URI="mirror://sourceforge/krecipes/${PN}_beta_${PV}.tar.gz"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"
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
	use sqlite || myconf="${myconf} --disable-sqlite"
	use mysql || myconf="${myconf} --disable-mysql"
	use postgres || myconf="${myconf} --disable-postgresql"

	kde_src_compile
}
