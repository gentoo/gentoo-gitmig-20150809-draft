# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kpnadsl4linux/kpnadsl4linux-1.10-r1.ebuild,v 1.10 2004/11/07 08:50:26 mrness Exp $

IUSE=""
DESCRIPTION="ADSL4Linux, a PPTP start/stop/etc. program especially for Dutch users, for gentoo."
HOMEPAGE="http://www.adsl4linux.nl/"
SRC_URI="http://home.planet.nl/~mcdon001/${P}.tar.gz
	http://www.adsl4linux.nl/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"
DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	sys-apps/gawk
	>=net-dialup/pptpclient-1.1.0
	>=net-dialup/ppp-2.4.0"

src_compile() {
	make || die "Make failed."
}

src_install() {
	dosbin adsl
	dodoc COPYING Changelog INSTALL README
	exeinto /etc/init.d/
	newexe init.d.adsl adsl
	dosbin ${FILESDIR}/${PN}-config
}

pkg_postinst() {
	einfo "Do _NOT_ forget to run the following if this is your _FIRST_ install:"
	einfo "kpnadsl4linux-config"
	einfo "etc-update"
	einfo
	einfo "To start ${P} at boot type:"
	einfo "rc-update add adsl default"
}
