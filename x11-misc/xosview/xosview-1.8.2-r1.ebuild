# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xosview/xosview-1.8.2-r1.ebuild,v 1.1 2005/09/17 18:18:39 truedfx Exp $

inherit eutils gnuconfig

DESCRIPTION="X11 operating system viewer"
SRC_URI="mirror://sourceforge/xosview/${P}.tar.gz"
HOMEPAGE="http://xosview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="~x86 ~alpha ~ppc ~amd64 ~sparc ~ppc64"

DEPEND="virtual/x11"
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
