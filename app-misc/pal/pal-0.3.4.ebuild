# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.3.4.ebuild,v 1.5 2004/10/01 12:40:32 pyrania Exp $

DESCRIPTION="pal command-line calendar program"
HOMEPAGE="http://palcal.sourceforge.net/"
SRC_URI="mirror://sourceforge/palcal/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2.0
	sys-devel/gettext
	virtual/libc
	sys-libs/readline"

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
