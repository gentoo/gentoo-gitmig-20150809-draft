# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/windowlab/windowlab-1.31.ebuild,v 1.5 2006/03/15 07:54:09 spyderous Exp $

IUSE=""

DESCRIPTION="WindowLab is a small and simple window manager of novel design."
HOMEPAGE="http://www.nickgravgaard.com/windowlab/"
SRC_URI="http://www.nickgravgaard.com/${PN}/${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="|| ( x11-libs/libXext virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

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
