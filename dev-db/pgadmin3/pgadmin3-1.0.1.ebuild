# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgadmin3/pgadmin3-1.0.1.ebuild,v 1.3 2003/12/18 19:59:09 nakano Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="wxWindows GUI for PostgreSQL"
HOMEPAGE="http://www.pgadmin.org/"
SRC_URI="mirror://postgresql/pgadmin3/release/src/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

# Need 2.4.1-r1 for the extras in contrib
DEPEND=">=x11-libs/wxGTK-2.4.1-r1"

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
