# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bridge-utils/bridge-utils-0.9.6-r1.ebuild,v 1.2 2004/04/02 20:37:15 aliz Exp $

# I think you want CONFIG_BRIDGE in your kernel to use this ;)

DESCRIPTION="Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
HOMEPAGE="http://bridge.sourceforge.net/"

S=${WORKDIR}/${PN}
SRC_URI="http://bridge.sourceforge.net/bridge-utils/${P}.tar.gz"

DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_compile() {
	econf --prefix=/ --libdir=/usr/lib --includedir=/usr/include
	emake || die "make failed"
}

src_install () {
	einstall prefix=${D} libdir=${D}/usr/lib includedir=${D}/usr/include
	dodoc AUTHORS ChangeLog README THANKS
	dodoc doc/{FAQ,FIREWALL,HOWTO,PROJECTS,SMPNOTES,WISHLIST}

	exeinto /etc/init.d
	newexe ${FILESDIR}/bridge.rc bridge

	insinto /etc/conf.d
	newins ${FILESDIR}/bridge.conf bridge
}

pkg_postinst () {
	ewarn "Gentoo now comes with a bridge init script. You can add it to"
	ewarn "the boot runlevel. You can configure it in /etc/conf.d/bridge"
}
