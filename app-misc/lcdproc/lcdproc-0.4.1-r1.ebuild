# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
# 20 Sept.2001 / 16.30 CET

S=${WORKDIR}/${P}
DESCRIPTION="lcdproc - displays system status on Matrix-Orbital 20x4 LCD on a serial port."
SRC_URI="http://lcdproc.omnipotent.net/${P}.tar.gz"
HOMEPAGE="http://lcdproc.omnipotent.net/"

DEPEND=">=sys-apps/baselayout-1.6.4"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
	make || die
}

src_install () {
	exeinto /usr/local/bin
	doexe server/LCDd
	doexe clients/lcdproc/lcdproc
	doman docs/lcdproc.1
	dodoc README ChangeLog COPYING INSTALL 
	docinto docs
	dodoc docs/README.dg docs/README.dg2 docs/hd44780_howto.txt docs/menustuff.txt docs/netstuff.txt 
	docinto clients/example
	dodoc clients/examples/fortune.pl clients/examples/iosock.pl clients/examples/tail.pl clients/examples/x11amp.pl 
	docinto clients/headlines
	dodoc clients/headlines/lcdheadlines

	# init.d & conf.d installation
	exeinto /etc/init.d
	doexe ${FILESDIR}/lcdproc
	insinto /etc/conf.d
	newins ${FILESDIR}/lcdproc.confd lcdproc
}

pkg_postinst () {
	rc-update add lcdproc default
}

pkg_postrm () {
	rc-update del lcdproc
}
