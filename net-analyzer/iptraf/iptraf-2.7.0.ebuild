# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-2.7.0.ebuild,v 1.19 2005/01/25 13:30:22 corsair Exp $

DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
SRC_URI="ftp://ftp.cebu.mozcom.com/pub/linux/net/${P}.tar.gz"
HOMEPAGE="http://cebu.mozcom.com/riker/iptraf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa mips"

DEPEND=">=sys-libs/ncurses-5.2-r1"
IUSE=""

src_compile() {
	cd src
	emake CFLAGS="$CFLAGS" DEBUG="" TARGET="/usr/sbin" WORKDIR="/var/lib/iptraf" \
	clean all || die "emake failed"
}

src_install() {
	dosbin src/{iptraf,cfconv,rvnamed}
	dodoc  FAQ README* CHANGES RELEASE-NOTES LICENSE INSTALL
	doman Documentation/*.8
	dohtml Documentation/*.html
	keepdir /var/{lib,run,log}/iptraf
}
