# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/ponyprog/ponyprog-2.06c.ebuild,v 1.2 2004/03/30 20:06:15 spyderous Exp $

RESTRICT="nomirror"

S=${WORKDIR}
DESCRIPTION="EEprom e Pic Programmer"
HOMEPAGE="http://www.lancos.com/ppwin95.html"
SRC_URI="http://www.lancos.com/e2p/V2_06/${P}-rh70.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="virtual/x11
	sys-libs/lib-compat
	sys-libs/glibc"

src_install () {
	dodir /etc/env.d
	echo "LDPATH='/opt/ponyprog/lib'" > ${D}/etc/env.d/40ponyprog || die
	insinto /etc/env.d
	doins etc/env.d/40ponyprog

	einfo "Installing binaries"

	into /opt/${PN}
	dobin ${S}/usr/local/bin/ponyprog2000
	dodir /opt/${PN}/lib
	dolib ${S}/usr/lib/*

	dodir /opt/bin
	dosym /opt/${PN}/bin/ponyprog2000 /opt/bin/ponyprog
}

pkg_postinst() {
	einfo "To use the COM port in user mode (not as root) you need"
	einfo "make sure you have the rights to write /dev/ttyS? devices "
	einfo "and /var/lock directory."
	einfo ""
	einfo "To use the LPT port in user mode (not as root) you need a 2.4.x kernel "
	einfo "with ppdev, parport and parport_pc compiled in as modules. You need the "
	einfo "rights to write /dev/parport? devices."
	einfo ""
	einfo "You can use /opt/bin/ponyprog"
}

