# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.3.3.ebuild,v 1.5 2004/06/24 22:28:21 agriffis Exp $

IUSE=""
DESCRIPTION="pal command-line calendar program"
SRC_URI="mirror://sourceforge/palcal/${P}.tgz"
HOMEPAGE="http://palcal.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"

S="${WORKDIR}/${P}/src"

DEPEND=">=dev-libs/glib-2.0
	sys-devel/gettext
	virtual/glibc
	sys-libs/readline"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e "s;^\(OPT[[:space:]]\+=\) -O2 -Wall;\1 ${CFLAGS};" Makefile.defs
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install-no-rm || die "make install failed"
}

