# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.3.3.ebuild,v 1.9 2006/05/26 20:44:31 flameeyes Exp $

DESCRIPTION="pal command-line calendar program"
HOMEPAGE="http://palcal.sourceforge.net/"
SRC_URI="mirror://sourceforge/palcal/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2.0
	sys-libs/readline
	virtual/libintl"

RDEPEND="${RDEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s;^\(OPT[[:space:]]\+=\) -O2 -Wall;\1 ${CFLAGS};" Makefile.defs
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install-no-rm || die "make install failed"
}
