# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wampager/wampager-0.9.ebuild,v 1.7 2002/10/04 06:43:44 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Pager for Waimea."
SRC_URI="http://download.sourceforge.net/waimea/${P}.tar.gz"
HOMEPAGE="http://waimea.sf.net"

DEPEND="x11-wm/waimea"
	 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch
	# now sed in a proper build image dir removing sandbox violates.
	mv Makefile Makefile.pre
	cat Makefile.pre | sed -e "s#@@@IMAGE_PRE@@@#${BUILDDIR}/image#" > Makefile
}
src_compile() {
	emake || die
}
src_install () {
	make install || die
}
