# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-0.8.1.ebuild,v 1.6 2005/11/23 09:31:55 chriswhite Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
SRC_URI="mirror://sourceforge/krecipes/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="mysql postgres sqlite"

DEPEND="sqlite? ( dev-db/sqlite )"

need-kde 3

pkg_setup() {
	if ! use sqlite && ! use mysql && ! use postgres; then
		eerror "krecipes needs either SQLite, MySQL or PostgreSQL to work,"
		eerror "please try again with USE=\"sqlite\","
		eerror "USE=\"mysql\" (and Qt compiled with USE=\"mysql\") or"
		eerror "USE=\"postgres\" (and Qt compiled with USE=\"postgres\")."
		die
	fi

	if use mysql && ! built_with_use x11-libs/qt mysql; then
		eerror "MySQL support was requested, but Qt"
		eerror "was compiled without MySQL support."
		eerror "Please reemerge Qt with USE=\"mysql\"."
		die "MySQL support for Qt not found"
	fi

	if use postgres && ! built_with_use x11-libs/qt postgres; then
		eerror "PostgreSQL support was requested, but Qt"
		eerror "was compiled without PostgreSQL support."
		eerror "Please reemerge Qt with USE=\"postgres\"."
		die "PostgreSQL support for Qt not found"
	fi
}

src_compile() {
	local myconf="$(use_with sqlite) $(use_with mysql) $(use_with postgres postgresql)"

	kde_src_compile
}
