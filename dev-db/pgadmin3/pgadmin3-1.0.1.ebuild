# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgadmin3/pgadmin3-1.0.1.ebuild,v 1.1 2003/11/06 16:42:25 nakano Exp $

DESCRIPTION="wxWindows GUI for PostgreSQL"

HOMEPAGE="http://www.pgadmin.org/"
SRC_URI="mirror://postgresql/pgadmin3/release/src/${P}.tar.gz"
LICENSE="Artistic"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

# Need 2.4.1-r1 for the extras in contrib
DEPEND=">=wxGTK-2.4.1-r1
	>=dev-db/postgresql-7.3"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	cd ${S}/src
	sed -i -e "s:^\(LIBS\).*:\1 = -lssl -lcrypto -lpq -lwx_gtk2-2.4	-lwx_gtk2_xrc-2.4 -lwx_gtk2_stc-2.4:" Makefile

	cd ${S}
	emake || die
}

src_install() {
	einstall || die
}
