# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-0.6.2.ebuild,v 1.1 2005/01/19 20:05:11 greg_g Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
SRC_URI="mirror://sourceforge/krecipes/${PN}_beta_${PV}.tar.gz"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="sqlite mysql"

DEPEND="sqlite? ( dev-db/sqlite )"
RDEPEND="${DEPEND}
	mysql? ( dev-db/mysql )"

need-kde 3

pkg_setup() {
	if ! use sqlite && ! use mysql; then
		eerror krecipes needs either SQLite or MySQL to work,
		eerror please try again with USE=\"sqlite\" or USE=\"mysql\".
		die
	fi
}
