# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bridge-utils/bridge-utils-0.9.6.ebuild,v 1.7 2004/06/17 06:32:33 jhhudso Exp $

# I think you want CONFIG_BRIDGE in your kernel to use this ;)

DESCRIPTION="Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
HOMEPAGE="http://bridge.sourceforge.net/"

S=${WORKDIR}/${PN}
SRC_URI="mirror://sourceforge/bridge/${P}.tar.gz"

DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	econf --prefix=/ --libdir=/usr/lib --includedir=/usr/include || die "econf failed"
	emake || die "make failed"
	test -f brctl/brctl -a -f brctl/brctld || die "build not successful"
}

src_install () {
	einstall prefix=${D} libdir=${D}/usr/lib includedir=${D}/usr/include
	dodoc AUTHORS ChangeLog README THANKS
	dodoc doc/{FAQ,FIREWALL,HOWTO,PROJECTS,SMPNOTES,WISHLIST}
}

pkg_postinst () {
	ewarn "brctl has been moved to /sbin - "
	ewarn "if you use it in your startup scripts, update them accordingly!"
}
