# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdesktopwaves/xdesktopwaves-1.3.ebuild,v 1.1 2004/12/20 08:06:41 dholm Exp $

inherit eutils

DESCRIPTION="A cellular automata setting the background of your X Windows desktop under water"
HOMEPAGE="http://xdesktopwaves.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="virtual/x11"

SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

src_compile() {
	emake || die "failed building program"
	cd xdwapi
	emake || die "failed building demo"
}

src_install() {
	dobin xdesktopwaves xdwapi/xdwapidemo
	doman xdesktopwaves.1
	insinto /usr/share/pixmaps
	doins xdesktopwaves.xpm
	make_desktop_entry xdesktopwaves "xdesktopwaves" xdesktopwaves.xpm
	dodoc COPYING README
}

pkg_preinst() {
	einfo "To see what xdesktopwaves is able to do, start it by running"
	einfo "'xdesktopwaves' and then run 'xdwapidemo'. You should see the"
	einfo "supported effects on your desktop"
}
