# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimmage/gimmage-0.1.8.ebuild,v 1.2 2006/02/14 03:42:37 deltacow Exp $

DESCRIPTION="A slim GTK-based image browser"
HOMEPAGE="http://gimmage.berlios.de/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-cpp/gtkmm
	net-misc/curl
	sys-apps/file"

#RDEPEND=${DEPEND} the same as DEPEND

src_compile()
{
	sed -i -e 's:/usr/local:/usr:g' Makefile
	if use debug; then
		einfo "Enabling debugging"
		emake debug || die "emake debug failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	exeinto /usr/bin
	if use debug; then
		doexe ${PN}-debug || die "installing debug failed"
	else
		doexe ${PN} || die "installing failed"
	fi
	dodir /usr/share/${PN}/icons
	insinto /usr/share/${PN}/icons
	doins icons/*.png
}
