# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/windowlab/windowlab-1.20.ebuild,v 1.1 2004/01/21 08:13:43 raker Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="some Amiga GUI rules + aewm 1.1.2 + 8 1/2 (from Plan9) = windowlab"
HOMEPAGE="http://www.nickgravgaard.com/windowlab/"
SRC_URI="http://www.nickgravgaard.com/${PN}/${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin windowlab

	newman windowlab.1x windowlab.1
	dodoc CHANGELOG README

	dodir /etc/X11/windowlab
	insinto /etc/X11/windowlab
	newins menurc.sample menurc

	dodir /etc/X11/Sessions
	echo "/usr/bin/${PN}" > ${D}/etc/X11/Sessions/${PN}
	fperms a+x /etc/X11/Sessions/${PN}
}
