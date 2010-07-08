# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbattbar/xbattbar-1.4.2.ebuild,v 1.11 2010/07/08 15:47:01 ssuominen Exp $

DESCRIPTION="Advanced Power Management battery status display for X"
HOMEPAGE="http://iplab.aist-nara.ac.jp/member/suguru/xbattbar.html"
SRC_URI="http://iplab.aist-nara.ac.jp/member/suguru/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/gccmakedep
	x11-misc/imake
	x11-libs/libX11"

src_compile() {
	xmkmf -a || die
	emake || die
}

src_install() {
	dobin xbattbar || die
	newman xbattbar.man xbattbar.1 || die
	dodoc README
}
