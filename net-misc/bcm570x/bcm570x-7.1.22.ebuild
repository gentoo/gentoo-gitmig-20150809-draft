# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm570x/bcm570x-7.1.22.ebuild,v 1.1 2004/04/09 03:33:05 steel300 Exp $

MY_P=${P/570x/5700}
SRC_URI="http://www.broadcom.com/docs/driver_download/570x/${MY_P}.tar.gz"
DESCRIPTION="Driver for the Broadcom 570x-based gigabit cards (found on many mainboards)."
HOMEPAGE="http://www.broadcom.com/docs/driver-sla.php?driver=570x-Linux"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S=${WORKDIR}/${PN/570x/5700}-${PV}/src

RESTRICT="fetch"

pkg_nofetch() {
	einfo "For legal reasons there is an license agreement with interaction"
	einfo "(the driver is GPL-2) -- so you have to download yourself."
	einfo "www.broadcom.com -> Download (NIC) drivers -> Linux. place the bmc5700*.tar.gz"
	einfo "in ${DISTDIR}."
}

src_compile() {
	local my_KV="$(uname -r)"

	cd ${S}
	make LINUX=/usr/src/linux-${my_KV} || die "compile failed"
}

src_install() {
	make PREFIX=${D} install || die

	doman bcm5700.4.gz
	dodoc DISTRIB.TXT LICENSE README.TXT RELEASE.TXT
}

pkg_postinst() {
	einfo "${P}.tar.gz also contains a kernel-patch to integrate this driver directly."
}
