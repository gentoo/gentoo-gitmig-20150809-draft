# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-2.7.0-r1.ebuild,v 1.11 2004/07/15 03:44:39 agriffis Exp $

V6PATCH_LEVEL=alpha11
DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
SRC_URI="ftp://ftp.cebu.mozcom.com/pub/linux/net/${P}.tar.gz http://dev.gentoo.org/~gmsoft/${P}-ipv6-${V6PATCH_LEVEL}.diff"
HOMEPAGE="http://cebu.mozcom.com/riker/iptraf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha hppa ~amd64 mips"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	use ipv6 && patch -p 0 < ${DISTDIR}/${P}-ipv6-${V6PATCH_LEVEL}.diff
	cd src
	cp dirs.h dirs.h.orig
	sed -e s:/var/local/iptraf:/var/lib/iptraf: -e s:/usr/local/bin:/usr/sbin: dirs.h.orig > dirs.h
}

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
