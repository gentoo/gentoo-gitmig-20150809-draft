# Copyright 2001-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-2.7.0.ebuild,v 1.4 2002/08/18 01:03:00 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
SRC_URI="ftp://ftp.cebu.mozcom.com/pub/linux/net/${P}.tar.gz"
HOMEPAGE="http://cebu.mozcom.com/riker/iptraf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.2-r1"
RDEPEND="${DEPEND}"

src_compile() {
	cd src
	emake TARGET="/usr/sbin" WORKDIR="/var/lib/iptraf" \
	clean all || die "emake failed"
}
src_install() {
	dosbin src/{iptraf,cfconv,rvnamed}
	dodoc  FAQ README* CHANGES RELEASE-NOTES
	doman Documentation/*.8
	htmlinto html
	dohtml Documentation/*.{html}
	dodir /var/{lib,run,log}/iptraf
}
