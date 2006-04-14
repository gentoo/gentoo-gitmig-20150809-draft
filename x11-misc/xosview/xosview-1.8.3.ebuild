# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xosview/xosview-1.8.3.ebuild,v 1.1 2006/04/14 18:27:10 nelchael Exp $

inherit eutils gnuconfig

DESCRIPTION="X11 operating system viewer"
SRC_URI="mirror://sourceforge/xosview/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXt )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/xosview-emptyxpaths.patch"
	epatch "${FILESDIR}/xosview-resdir.patch"
	gnuconfig_update # for ppc64, but no reason to restrict it
}

src_install() {
	exeinto /usr/bin
	doexe xosview
	insinto /etc/X11/app-defaults
	newins Xdefaults XOsview
	doman *.1
	dodoc CHANGES README README.linux TODO
}
