# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/net-im/gabber/gabber-0.8.7-r1.ebuild,v 1.5 2002/06/08 15:38:09 spider Exp

S="${WORKDIR}/msn"
DESCRIPTION="Alvarro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://amsn.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/tcl-8.3.3"

src_compile() {
	
	make \
		prefix=${D}/usr \
		gnomelinks=${D}/etc/X11/applnk/Internet \
		kdelinks=${D}/usr/share/applnk/Internet \
		wmapps=${D}/etc/X11/applnk/Internet || die

}

src_install() {
	make \
		prefix=${D}/usr \
		wmapps=${D}/etc/X11/applnk/Internet \
		install || die

	rm -f ${D}/usr/bin/amsn
	ln -s /usr/share/amsn/amsn ${D}/usr/bin/amsn	

	dodoc LEEME TODO README GNUGPL

}
