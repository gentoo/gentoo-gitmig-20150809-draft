# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-2.4.0-r1.ebuild,v 1.2 2002/07/11 06:30:43 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
SRC_URI="ftp://ftp.cebu.mozcom.com/pub/linux/net/${P}.tar.gz"
HOMEPAGE="http://cebu.mozcom.com/riker/iptraf/"

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_compile() {
	cd src
	emake TARGET="/usr/bin" WORKDIR="/var/lib/iptraf" \
		clean all || die "emake failed"
}

src_install() {

	dobin src/{iptraf,cfconv,rvnamed}
	dodoc COPYING FAQ README* CHANGES RELEASE-NOTES
	doman Documentation/*.8
	docinto html
	dodoc Documentation/*.{gif,html}
	dodir /var/{lib,run,log}/iptraf
}
