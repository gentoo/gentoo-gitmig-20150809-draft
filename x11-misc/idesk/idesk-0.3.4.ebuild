# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.3.4.ebuild,v 1.4 2003/09/05 00:57:57 msterret Exp $
DESCRIPTION="Utility to place icons on the root window"

HOMEPAGE="http://linuxhelp.hn.org/idesk.php"
SRC_URI="http://linuxhelp.hn.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND=">media-libs/imlib-1.9.14
	virtual/x11"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	#Allow for more robust CXXFLAGS
	mv Makefile Makefile.orig
	sed -e "s/-g -O2/${CXXFLAGS}/" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe idesk
	dodoc README
}

pkg_postinst() {
	einfo
	einfo "NOTE: Please refer to ${HOMEPAGE}"
	einfo "NOTE: For info on configuring ${PN}"
	einfo
}
