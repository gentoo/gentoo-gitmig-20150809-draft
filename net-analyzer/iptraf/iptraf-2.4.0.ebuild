# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bryce Porter <x86@gentoo.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
SRC_URI="ftp://ftp.cebu.mozcom.com/pub/linux/net/${A}"
HOMEPAGE="http://cebu.mozcom.com/riker/iptraf/"

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_compile() {
	cd src
	cp Makefile Makefile.orig
	sed -e "s:-O2:$CFLAGS:g" \
	    -e "s:/var/local/iptraf:/var/lib/iptraf:" \
		Makefile.orig >Makefile
	try make clean all
}

src_install() {

	dobin src/{iptraf,cfconv,rvnamed}
	dodoc COPYING FAQ README* CHANGES RELEASE-NOTES
	doman Documentation/*.8
	docinto html
	dodoc Documentation/*.{gif,html}
	dodir /var/{lib,run,log}/iptraf
}
