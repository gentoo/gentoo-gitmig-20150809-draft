# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-1.0_beta1.ebuild,v 1.5 2008/05/21 16:02:28 dev-zero Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://sourceforge/krecipes/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mysql postgres sqlite"

DEPEND="sqlite? ( dev-db/sqlite )
		!sqlite? ( !mysql? ( !postgres? ( dev-db/sqlite ) ) )"
RDEPEND="${DEPEND}
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"

RESTRICT="test"

need-kde 3

src_compile() {
	if ! use sqlite && ! use mysql && ! use postgres; then
		myconf="--with-sqlite"
	else
		myconf="$(use_with sqlite) $(use_with mysql) $(use_with postgres postgresql)"
	fi

	kde_src_compile
}
