# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20020418-r1.ebuild,v 1.4 2002/12/13 10:18:50 azarah Exp $

DXVER="501"
DESCRIPTION="Binary release of DivX Codec 5.0.1"
SRC_URI="http://download.divx.com/divx/${PN}${DXVER}-${PV}.tgz"
HOMEPAGE="http://www.divx.com/"

SLOT="0"
LICENSE="DIVX"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/glibc"

DEBUG="yes"
RESTRICT="nostrip"

src_install() {
	for lib in *.so ; do
		dolib.so ${lib}
		dosym /usr/lib/${lib} /usr/lib/${lib}.0
	done

	insinto /usr/include
	doins *.h

	dodoc README.linux license.txt
	dodir /usr/share/doc/${PF}/html
	cp -a 'DivX MPEG-4 Codec and Its Interface.htm' ${D}/usr/share/doc/${PF}/html
}

