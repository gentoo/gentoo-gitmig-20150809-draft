# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.3.2.ebuild,v 1.1 2004/01/08 22:55:23 wschlich Exp $

IUSE=""
DESCRIPTION="pal command-line calendar program"
SRC_URI="mirror://sourceforge/palcal/${P}.tgz"
HOMEPAGE="http://palcal.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P}/src"

DEPEND=">=dev-libs/glib-2.0
	sys-devel/gettext
	virtual/glibc
	sys-libs/readline"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e "s;^\(INCLDIR = -I\)/usr/local/include;\1/usr/include;" Makefile
	sed -i -e "s;^\(OPT[[:space:]]\+=\) -O2 -Wall;\1 ${CFLAGS};" Makefile.defs
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install-no-rm || die "make install failed"
}

