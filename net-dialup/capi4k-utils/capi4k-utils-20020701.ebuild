# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-utils/capi4k-utils-20020701.ebuild,v 1.7 2003/05/03 09:05:05 killian Exp $

YEAR_PV=${PV:0:4}
MON_PV=${PV:4:2}
DAY_PV=${PV:6:2}

MY_P=${PN}-${YEAR_PV}-${MON_PV}-${DAY_PV}

S=${WORKDIR}/${PN}
DESCRIPTION="Capi4Linux Utils"
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/OLD/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/linux-sources
	sys-devel/automake"

src_compile() {
	emake subconfig || die
	emake || die
}

src_install() { 
	dodir /dev
	make install DESTDIR=${D} || die
	rm -rf ${D}/dev
	newdoc rcapid/README README.rcapid
	newdoc pppdcapiplugin/README README.pppdcapiplugin
	docinto examples.pppdcapiplugin; dodoc pppdcapiplugin/examples/*
	exeinto /etc/init.d
	doexe ${FILESDIR}/capi
}

pkg_postinst() {
	einfo "To use isdn4linux with CAPI replace"
	einfo "I4L_MODULE=\"hisax\" with I4L_MODULE=\"capidrv\","
	einfo "start /etc/init.d/capi and load the module"
	einfo "capidrv."
}
